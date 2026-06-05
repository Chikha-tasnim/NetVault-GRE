
# Linux Network Namespace & GRE Tunneling Lab

This repository features an automated network emulation environment built inside Linux using native kernel components. It simulates a corporate WAN architecture containing a central enterprise hub and two branch offices.

## Network Architecture Concept
The lab instantiates distinct network entities isolated at Layer 2 and Layer 3 via Linux Network Namespaces:
- **HUB**: The central routing core.
- **SITE1**: Branch office 1.
- **SITE2**: Branch office 2.

### Interconnects & Overlay
- **Virtual Ethernet (veth) pairs** establish local point-to-point connections to simulate physical links.
- **GRE (Generic Routing Encapsulation) Tunnels** are established on top of the base network to create secure, logical overlay channels connecting the branches together through the hub.

## How to Run
Execute the deployment script with root privileges to initialize interfaces, routing logic, and namespaces:
```bash
sudo ./start-lab.sh

## What the Script Does
1. Creates 3 isolated network namespaces (HUB, SITE1, SITE2)
2. Connects them with virtual ethernet pairs
3. Assigns IP addresses to each interface
4. Creates GRE tunnels between sites and hub
5. Configures routing between all sites

## Author
Chikha-tasnim

