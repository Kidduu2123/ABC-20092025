#!/bin/bash

echo "==== Default Gateway ===="
ip route | grep default

GATEWAY_IP=$(ip route | grep default | awk '{print $3}')

if [ -z "$GATEWAY_IP" ]; then
  echo "No default gateway found!"
  exit 1
fi

echo "==== Full Routing Table ===="
ip route show

echo "==== Ping Gateway ===="
ping -c 4 $GATEWAY_IP

if [ $? -eq 0 ]; then
  echo "Gateway $GATEWAY_IP is reachable."
else
  echo "Gateway $GATEWAY_IP is NOT reachable."
