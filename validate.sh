#!/bin/bash

CORE_IP="192.168.70.101"
DNS_IP="8.8.8.8"
INTERNET_TEST_HOST="google.com"
ENB_IP="192.168.60.1"

function check_route_table() {
    echo "==> Checking routing table..."
    ip route show
    echo ""
}

function ping_host() {
    local name=$1
    local host=$2

    echo "==> Pinging $name ($host)..."
    ping -c 3 $host > /dev/null

    if [ $? -eq 0 ]; then
        echo "$name reachable"
    else
        echo "$name NOT reachable"
    fi
    echo ""
}

function test_dns() {
    echo "==> Testing DNS resolution..."
    nslookup $INTERNET_TEST_HOST $DNS_IP > /dev/null
    if [ $? -eq 0 ]; then
        echo "DNS working"
    else
        echo "DNS resolution failed"
    fi
    echo ""
}

function test_external_connectivity() {
    echo "==> Testing internet access via curl..."
    curl -s --head https://www.google.com | head -n 1
    if [ $? -eq 0 ]; then
        echo "Internet access working"
    else
        echo "Internet access failed"
    fi
    echo ""
}

echo "============================"
echo " AGW Routing Validation"
echo "============================"

check_route_table
ping_host "Core Network (MME/AMF)" "$CORE_IP"
ping_host "Public DNS" $DNS_IP
ping_host "eNodeB" $ENB_IP
test_dns
test_external_connectivity

echo "Validation Complete."
