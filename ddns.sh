#!/bin/bash
#API_KEY=**** SUBDOMAIN=*** ./ddns.sh
# This script gets the external IP of your systems then connects to the Gandi
# LiveDNS API and updates your dns record with the IP.

# Gandi LiveDNS API KEY # use env vars
# API_KEY="............"

# Domain hosted with Gandi
DOMAIN="bhscs.club"

# Subdomain to update DNS
SUBDOMAIN="$SUBDOMAIN.servers"

# Get external IP address
EXT_IP=$(curl -s ifconfig.me)  

curl -D- -X PUT -H "Content-Type: application/json" \
        -H "Authorization: Apikey $API_KEY" \
        -d "{\"rrset_name\": \"$SUBDOMAIN\",
             \"rrset_type\": \"A\",
             \"rrset_ttl\": 1200,
             \"rrset_values\": [\"$EXT_IP\"]}" \
        https://api.gandi.net/v5/livedns/domains/$DOMAIN/records/$SUBDOMAIN/A