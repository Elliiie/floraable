#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>
#include <BH1750FVI.h>

BH1750FVI lightMeter(BH1750FVI::k_DevModeContLowRes);

#include "DHTesp.h"

DHTesp dht;

//003F0902
//4131074


const char* ssid = "Venci-SetSERVICE";
const char* password ="20061017";
const char* mqtt_server = "192.168.0.106";

WiFiClient espClient;
PubSubClient client(espClient);

//leds
const int ledGPIO5 = 12;

//dht 
long now = millis();
long lastMeasure = 0;

//soil moisture
const int analog = A0;     
int inputVal  = 0; 

//water pump
const int pump = 13;

int period = 60000;

unsigned long time_now = 0;


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
      Serial.print("Changing GPIO 12 to ");
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
      
      client.subscribe("profile/4131074/esp8266/12");
      client.subscribe("profile/4131074/esp8266/13");
      
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

  Wire.begin(D1, D2);
  lightMeter.begin();
  dht.setup(D5, DHTesp::DHT22); // Connect DHT sensor to GPIO 17
}
 

void send_tempreture(){
  

        lastMeasure = now;
        
        float h = dht.getHumidity();
        float t = dht.getTemperature();
            
        if (isnan(h) || isnan(t)) {
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
        client.publish(topicHumidity.c_str(), humidityTemp);  
    
        
        Serial.print("Humidity: ");
        Serial.print(h);
        Serial.print(" %\t Temperature: ");
        Serial.print(t);
        Serial.print(" *C ");
        Serial.print(hic);
        Serial.println(" *C ");
    
}

void send_moisture(){
 
      inputVal = analogRead (analog); 
      Serial.println("Soil moisture: ");
      Serial.println(inputVal);
      static char soilmoisture[7];
      dtostrf(inputVal, 6, 2, soilmoisture);
      String topicMoisture = ("/profile/4131074/esp8266/soilMoisture");
      client.publish(topicMoisture.c_str(), soilmoisture);  
  
}

void send_light(){

      uint16_t lux = lightMeter.GetLightIntensity();
      static char lightLux[7];
      dtostrf(lux, 6, 2, lightLux);
      String topicLight = ("/profile/4131074/esp8266/light");
      client.publish(topicLight.c_str(), lightLux);  
      Serial.println("Light level: ");
      Serial.println (lux);  
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  if(!client.loop()){
    Serial.print("opaaa");
    client.connect("ESP8266Client");
  }
  
    send_tempreture();
    send_moisture();
    send_light();
    
    delay(60000);
      
    //Serial.println("id: ");
    //Serial.println(ESP.getChipId());
    //delay(2000);
    
}
