#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>
#include <BH1750FVI.h>
#include "DHT.h"

#define DHTTYPE DHT22

//003F0902

uint8_t ADDRESSPIN = 13;
BH1750FVI::eDeviceAddress_t DEVICEADDRESS = BH1750FVI::k_DevAddress_H;
BH1750FVI::eDeviceMode_t DEVICEMODE = BH1750FVI::k_DevModeContHighRes;

BH1750FVI lightMeter(ADDRESSPIN, DEVICEADDRESS, DEVICEMODE);

const char* ssid = "Venci-SetSERVICE";
const char* password = "20061017";
const char* mqtt_server = "192.168.0.106";

WiFiClient espClient;
PubSubClient client(espClient);

const int ledGPIO5 = 5;
const int ledGPIO4 = 4;

const int DHTPin = 14; 

const int analog = A0;     
int inputVal  = 0; 

DHT dht(DHTPin, DHTTYPE);

long now = millis();
long lastMeasure = 0;

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

  if(topic==("%s/esp8266/4", String(ESP.getChipId()))){
      Serial.print("Changing GPIO 4 to ");
      if(messageTemp == "1"){
        digitalWrite(ledGPIO4, HIGH);
        Serial.print("On");
      }
      else if(messageTemp == "0"){
        digitalWrite(ledGPIO4, LOW);
        Serial.print("Off");
      }
  }
  if(topic==("%s/esp8266/5", String(ESP.getChipId()))){
      Serial.print("Changing GPIO 5 to ");
      if(messageTemp == "1"){
        digitalWrite(ledGPIO5, HIGH);
        Serial.print("On");
      }
      else if(messageTemp == "0"){
        digitalWrite(ledGPIO5, LOW);
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
      String topic1 = ("%s/esp8266/4", String(ESP.getChipId()));
      String topic2 = ("%s/esp8266/5", String(ESP.getChipId()));
      
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
  pinMode(ledGPIO4, OUTPUT);
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
  //read_light_sensor();
 // delay(60000);
  
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

    String topicTemperature = ("%s/esp8266/temperature", String(ESP.getChipId()));
    client.publish(topicTemperature.c_str(), temperatureTemp);  

    String topicHumidity = ("%s/esp8266/humidity", String(ESP.getChipId()));
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
    inputVal = analogRead (analog); 
    Serial.println("Soil moisture: ");
    Serial.println(inputVal);
    Serial.println("------");
    Serial.println("Light level: ");
    Serial.println (lux);
    delay(2000);
    
    delay(1000);
    }
}
