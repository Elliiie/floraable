#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>
#include <BH1750FVI.h>
#include "DHT.h"

#define DHTTYPE DHT22

//003F0902
//4131074

uint8_t ADDRESSPIN = 13;
BH1750FVI::eDeviceAddress_t DEVICEADDRESS = BH1750FVI::k_DevAddress_H;
BH1750FVI::eDeviceMode_t DEVICEMODE = BH1750FVI::k_DevModeContHighRes;

BH1750FVI lightMeter(ADDRESSPIN, DEVICEADDRESS, DEVICEMODE);

const char* ssid = "Venci-SetSERVICE";
const char* password = "20061017";
const char* mqtt_server = "192.168.0.106";

WiFiClient espClient;
PubSubClient client(espClient);

//leds
const int ledGPIO5 = 12;

//dht 
const int DHTPin = 14;
DHT dht(DHTPin, DHTTYPE); 
long now = millis();
long lastMeasure = 0;

//soil moisture
const int analog = A0;     
int inputVal  = 0; 

//water pump
const int pump = 13;


void setup_wifi() {

  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  lightMeter.begin();
  Serial.println(F("BH1750 Test"));
}

void callback(String topic, byte* message, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.print(topic);
  Serial.print(". Message: ");
  String messageTemp;
  
  for (int i = 0; i < length; i++) {
    Serial.print((char)message[i]);
    messageTemp += (char)message[i];
  }
  Serial.println();

  if(topic==("profile/4131074/esp8266/12")){
      Serial.print("Changing GPIO 13 to ");
      if(messageTemp == "1"){
        digitalWrite(ledGPIO5, HIGH);
        Serial.print("On");
      }
      else if(messageTemp == "0"){
        digitalWrite(ledGPIO5, LOW);
        Serial.print("Off");
      }
  }
  if(topic==("profile/4131074/esp8266/13")){
      Serial.print("Changing GPIO 13 to ");
      if(messageTemp == "1"){
        digitalWrite(pump, HIGH);
        Serial.print("On");
      }
      else if(messageTemp == "0"){
        digitalWrite(pump, LOW);
        Serial.print("Off");
      }
  }
  Serial.println();
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP8266Client")) {
      Serial.println("connected");  
      
      String topic1 = ("profile/4131074/esp8266/12");
      String topic2 = ("profile/4131074/esp8266/15");
      
      client.subscribe(topic1.c_str());
      client.subscribe(topic2.c_str());
      
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void setup() {
  pinMode(pump, OUTPUT);
  pinMode(ledGPIO5, OUTPUT);
  
  Serial.begin(9600);
  setup_wifi();
  
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  
  dht.begin();
}
 

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  if(!client.loop()){
    Serial.print("opaaa");
    client.connect("ESP8266Client");
  }
  
  now = millis();
  if (now - lastMeasure > 10000) {
    lastMeasure = now;
    
    float h = dht.readHumidity();
    float t = dht.readTemperature();
    
    float f = dht.readTemperature(true);

    if (isnan(h) || isnan(t) || isnan(f)) {
      Serial.println("Failed to read from DHT sensor!");
      return;
    }

    float hic = dht.computeHeatIndex(t, h, false);
    static char temperatureTemp[7];
    dtostrf(hic, 6, 2, temperatureTemp);
    
    static char humidityTemp[7];
    dtostrf(h, 6, 2, humidityTemp);

    String topicTemperature = ("/profile/4131074/esp8266/temperature");
    client.publish(topicTemperature.c_str(), temperatureTemp);  

    String topicHumidity = ("/profile/4131074/esp8266/humidity");
    client.publish(topicHumidity.c_str(), temperatureTemp);  

    
    Serial.print("Humidity: ");
    Serial.print(h);
    Serial.print(" %\t Temperature: ");
    Serial.print(t);
    Serial.print(" *C ");
    Serial.print(f);
    Serial.print(" *F\t Heat index: ");
    Serial.print(hic);
    Serial.println(" *C ");

    uint16_t lux = lightMeter.GetLightIntensity();
    static char lightLux[7];
    dtostrf(lux, 6, 2, lightLux);
    
    inputVal = analogRead (analog); 
    String topicLight = ("/profile/4131074/esp8266/light");
    client.publish(topicLight.c_str(), lightLux);  
    
    Serial.println("Soil moisture: ");
    Serial.println(inputVal);
    
    Serial.println("------");
    
    Serial.println("Light level: ");
    Serial.println (lux);

    Serial.println("id: ");
    Serial.println(ESP.getChipId());
    delay(2000);
    
    }
}
