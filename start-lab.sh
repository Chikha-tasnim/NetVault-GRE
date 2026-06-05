#!/bin/bash
ip netns add HUB
ip netns add SITE1
ip netns add SITE2
ip link add hub-s1 type veth peer name s1-hub
ip link add hub-s2 type veth peer name s2-hub
ip link set hub-s1 netns HUB
ip link set s1-hub  netns SITE1
ip link set hub-s2 netns HUB
ip link set s2-hub  netns SITE2
ip netns exec HUB   ip link set lo up
ip netns exec HUB   ip link set hub-s1 up
ip netns exec HUB   ip link set hub-s2 up
ip netns exec SITE1 ip link set lo up
ip netns exec SITE1 ip link set s1-hub up
ip netns exec SITE2 ip link set lo up
ip netns exec SITE2 ip link set s2-hub up
ip netns exec HUB   ip addr add 10.0.1.1/24 dev hub-s1
ip netns exec HUB   ip addr add 10.0.2.1/24 dev hub-s2
ip netns exec SITE1 ip addr add 10.0.1.2/24 dev s1-hub
ip netns exec SITE2 ip addr add 10.0.2.2/24 dev s2-hub
ip netns exec HUB   sysctl -w net.ipv4.ip_forward=1
ip netns exec HUB   iptables -P FORWARD ACCEPT
ip netns exec HUB   iptables -F
ip netns exec SITE1 ip route add default via 10.0.1.1 dev s1-hub
ip netns exec SITE1 ip route add 10.0.2.0/24 via 10.0.1.1 dev s1-hub
ip netns exec SITE2 ip route add default via 10.0.2.1 dev s2-hub
ip netns exec SITE2 ip route add 10.0.1.0/24 via 10.0.2.1 dev s2-hub
ip netns exec HUB ip tunnel add gre1 mode gre local 10.0.1.1 remote 10.0.1.2 ttl 255
ip netns exec HUB ip link set gre1 up
ip netns exec HUB ip addr add 172.16.1.1/30 dev gre1
ip netns exec HUB ip tunnel add gre2 mode gre local 10.0.2.1 remote 10.0.2.2 ttl 255
ip netns exec HUB ip link set gre2 up
ip netns exec HUB ip addr add 172.16.2.1/30 dev gre2
ip netns exec SITE1 ip tunnel add gre1 mode gre local 10.0.1.2 remote 10.0.1.1 ttl 255
ip netns exec SITE1 ip link set gre1 up
ip netns exec SITE1 ip addr add 172.16.1.2/30 dev gre1
ip netns exec SITE2 ip tunnel add gre2 mode gre local 10.0.2.2 remote 10.0.2.1 ttl 255
ip netns exec SITE2 ip link set gre2 up
ip netns exec SITE2 ip addr add 172.16.2.2/30 dev gre2
echo "Lab ready!"
