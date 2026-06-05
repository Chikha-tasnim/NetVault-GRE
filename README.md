# NetVault-GRE
### Multi-Site VPN Lab — GRE over IPsec with Hub-and-Spoke Topology

> A hands-on network security lab simulated entirely inside a Linux virtual 
> machine using kernel-native tools. No physical hardware required.

---

## What This Lab Simulates
This lab recreates a real corporate WAN architecture where:
- A **central headquarters (HUB)** connects to two remote branch offices
- All traffic between sites travels through **encrypted GRE tunnels**
- **IPsec** provides the encryption layer over each tunnel
- Sites discover each other automatically via **OSPF dynamic routing**

----

## Network Topology
SITE1 (10.0.1.2)
     |
[GRE + IPsec Tunnel]
     |
HUB (10.0.1.1 / 10.0.2.1)
     |
[GRE + IPsec Tunnel]
     |
SITE2 (10.0.2.2)
---

## Technologies Used
| Technology | Purpose |
|---|---|
| Linux Network Namespaces | Isolate each site like a real router |
| veth pairs | Simulate physical cable links |
| GRE Tunnels | Create logical overlay network |
| IPsec (xfrm) | Encrypt all tunnel traffic |
| OSPF | Dynamic routing between all sites |

---

## Network Architecture
The lab instantiates distinct network entities isolated at Layer 2 and Layer 3
via Linux Network Namespaces:

- **HUB** — The central routing core (headquarters)
- **SITE1** — Branch office 1
- **SITE2** — Branch office 2

### Interconnects & Overlay
- **Virtual Ethernet (veth) pairs** establish point-to-point connections
  to simulate physical links between namespaces
- **GRE Tunnels** create secure logical overlay channels connecting
  the branch offices through the central hub
- **IPsec (xfrm)** encrypts all traffic passing through the GRE tunnels

---

## Requirements
- Linux machine or VM (Kali, Ubuntu, Debian)
- Root privileges
- No extra packages needed — uses native Linux kernel tools only

---

## How to Run
```bash
# Clone the repository
git clone https://github.com/Chikha-tasnim/NetVault-GRE.git
cd NetVault-GRE

# Give execute permission
chmod +x start-lab.sh

# Run the lab
sudo ./start-lab.sh
```

---

## What the Script Does
1. Creates 3 isolated network namespaces (HUB, SITE1, SITE2)
2. Connects them with virtual ethernet (veth) pairs
3. Assigns IP addresses to each interface
4. Enables IP forwarding and configures firewall rules on HUB
5. Creates GRE tunnels between each site and the hub
6. Configures IPsec encryption over the tunnels
7. Sets up routing between all sites

---

## Verify the Lab is Working
```bash
# Check namespaces were created
ip netns list

# Test connectivity from SITE1 to SITE2 through HUB
sudo ip netns exec SITE1 ping -c 3 172.16.2.2

# Check GRE tunnels
sudo ip netns exec HUB ip tunnel show

# Check routing tables
sudo ip netns exec SITE1 ip route show
sudo ip netns exec SITE2 ip route show
```

---

## Lab Environment
- Tested on: Kali Linux (VMware Workstation)
- Kernel: Linux 6.x
- No physical hardware required

---

## Author
**Chikha-tasnim**  
Network Security Lab — Multi-Site VPN with IPsec and GRE

     
