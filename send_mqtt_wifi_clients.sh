#!/bin/sh
# Petit script qui envoie le nombre de clients WIFI connecté sur l'AP WIFI à un brocker MQTT
# 
# zf241003.1331

zAPP_FOLDER=$(/usr/bin/dirname $0)
zHOSTNAME=$(/sbin/uci get system.@system[0].hostname)

source $zAPP_FOLDER/secrets.sh

MQTT_TOPIC="$zHOSTNAME/$zHOSTNAME/$zHOSTNAME-nbClients/stat_t"

echo -e "
zAPP_FOLDER: $zAPP_FOLDER
zHOSTNAME: $zHOSTNAME
MQTT_BROKER: $MQTT_BROKER
MQTT_PORT: $MQTT_PORT
MQTT_TOPIC: $MQTT_TOPIC
MQTT_USERNAME: $MQTT_USERNAME
MQTT_PASSWORD: $MQTT_PASSWORD
"

MQTT_DISCOVERY_TOPIC="homeassistant/sensor/$zHOSTNAME/$zHOSTNAME-nbClients/config"

# Configuration de la découverte MQTT
DISCOVERY_PAYLOAD='{
  "name": "nbClients",
  "unique_id": "'$zHOSTNAME'-nbClients",
  "icon": "mdi:counter",
  "unit_of_measurement": "cmpt",
  "device": {
    "identifiers": ["'$zHOSTNAME'"],
    "name": "'$zHOSTNAME'",
    "sw_version": "zf241003.1212",
    "manufacturer": "openwrt",
    "model": "mini Mango"
  },
  "state_topic": "'$zHOSTNAME'/'$zHOSTNAME'/'$zHOSTNAME'-nbClients/stat_t"
}'




# Obtenir le nombre de clients Wi-Fi associés
CLIENT_COUNT=$(iwinfo phy0-ap0 assoclist | grep dBm | wc -l)

echo -e "CLIENT_COUNT: $CLIENT_COUNT"

# Envoyer le message de découverte MQTT
zSEND_MQTT_CMD="-h $MQTT_BROKER -p $MQTT_PORT -t $MQTT_DISCOVERY_TOPIC -u $MQTT_USERNAME -P $MQTT_PASSWORD -m \"$DISCOVERY_PAYLOAD\""
echo -e "zSEND_MQTT_CMD: mosquitto_pub $zSEND_MQTT_CMD"

/usr/bin/mosquitto_pub -h $MQTT_BROKER -p $MQTT_PORT -t $MQTT_DISCOVERY_TOPIC -u $MQTT_USERNAME -P $MQTT_PASSWORD -m "$DISCOVERY_PAYLOAD"


# Envoyer le nombre de clients au broker MQTT
zSEND_MQTT_CMD="-h $MQTT_BROKER -p $MQTT_PORT -t $MQTT_TOPIC -u $MQTT_USERNAME -P $MQTT_PASSWORD -m $CLIENT_COUNT"
echo -e "zSEND_MQTT_CMD: mosquitto_pub $zSEND_MQTT_CMD"

/usr/bin/mosquitto_pub -h $MQTT_BROKER -p $MQTT_PORT -t $MQTT_TOPIC -u $MQTT_USERNAME -P $MQTT_PASSWORD -m $CLIENT_COUNT



echo -e "

Si jamais pour info:

export VISUAL=nano; crontab -e

*/1 * * * * /mnt/sda1/mango/send_mqtt__wifi_clients.sh

ou ceci pour avoir les logs:

*/1 * * * * /mnt/sda1/mango/send_mqtt_wifi_clients.sh >> /tmp/toto.log 2>&1

crontab -l

IMPORTANT, APRES IL FAUT FAIRE CECI:

service cron restart






"
