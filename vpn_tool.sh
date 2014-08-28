#!/bin/bash
# a quick script to make vpns
echo -n "Group policy name?"
read group
echo -n "User name?"
read user
echo -n "Host to access?"
read host
psk=`pwgen 12 1`
pass=`pwgen 12 1`

echo "access-list $group_splitTunnelAcl standard permit 172.16.0.0 255.255.0.0"
echo "access-list $group_users extended permit tcp any host $host eq 3389"
echo "access-list $group_users extended permit icmp any any "
echo "access-list $group_users extended deny ip any any"

echo "group-policy $group internal"
echo "group-policy $group attributes"
echo " vpn-filter value '$group'_users"
echo " vpn-tunnel-protocol IPSec"
echo " split-tunnel-policy tunnelspecified"
echo " split-tunnel-network-list value '$group'_splitTunnelAcl"

echo "tunnel-group $group type remote-access"
echo "tunnel-group $group general-attributes"
echo " address-pool VPN_ips"
echo " default-group-policy $group"
echo "tunnel-group $group ipsec-attributes"
echo " pre-shared-key $psk"

echo "username $user password $pass privilege 0"
echo "username $user attributes"
echo " vpn-group-policy $group"
