# Cybersecurity Master Review Guide
## Everything Covered Through the Enterprise Active Directory Security Lab (Days 1-30)

**Purpose:** Personal study, review, retention, interview preparation, and rebuilding skills from memory.

**Cutoff:** This guide stops at the completion of the **Enterprise Active Directory Security Lab / Day 30**. It does **not** try to include the later Phase 2 material unless a later correction is necessary to accurately understand something learned during Days 1-30.

**Primary source basis:** the `Cyber-IT-Notebook` GitHub repository, especially the Day 1-30 PDFs in `uncategorized_notes`, plus the completed Active Directory lab history and corrections recorded during the work.

> **Important source note:** This is a consolidation, not a word-for-word concatenation of every PDF. Some early PDFs were not directly machine-readable in the current environment. Where later notes explicitly said that a concept had already been covered (for example ports, ARP, DHCP, NAT, `netstat`, and Nmap), those concepts are included as **earlier referenced foundations**. I did not invent a fake day-by-day history for material I could not directly recover.

---

# Table of Contents

1. [The Big Picture](#1-the-big-picture)
2. [Cybersecurity Foundations](#2-cybersecurity-foundations)
3. [Networking Foundations](#3-networking-foundations)
4. [OSI Model, TCP, UDP, and Packets](#4-osi-model-tcp-udp-and-packets)
5. [DNS, HTTP, HTTPS, TLS, Ping, and Routing](#5-dns-http-https-tls-ping-and-routing)
6. [Wireshark and Packet Analysis](#6-wireshark-and-packet-analysis)
7. [Windows Internals](#7-windows-internals)
8. [Windows Networking and Firewall Foundations](#8-windows-networking-and-firewall-foundations)
9. [Windows Security Logging and Detection](#9-windows-security-logging-and-detection)
10. [PowerShell Foundations](#10-powershell-foundations)
11. [Windows Server and Enterprise Roles](#11-windows-server-and-enterprise-roles)
12. [Active Directory Foundations](#12-active-directory-foundations)
13. [AD Forests, Trees, Schema, Global Catalog, and Trusts](#13-ad-forests-trees-schema-global-catalog-and-trusts)
14. [DNS Inside Active Directory](#14-dns-inside-active-directory)
15. [Kerberos, NTLM, Authentication, and Authorization](#15-kerberos-ntlm-authentication-and-authorization)
16. [LDAP and Directory Queries](#16-ldap-and-directory-queries)
17. [Group Policy](#17-group-policy)
18. [SMB, NTFS, and Enterprise File Access](#18-smb-ntfs-and-enterprise-file-access)
19. [AGDLP and Role-Based Access](#19-agdlp-and-role-based-access)
20. [VMware and Lab Architecture](#20-vmware-and-lab-architecture)
21. [Project 1 - Building the Domain Controller](#21-project-1---building-the-domain-controller)
22. [Project 1 - Active Directory Administration](#22-project-1---active-directory-administration)
23. [Project 1 - Building and Joining CLIENT01](#23-project-1---building-and-joining-client01)
24. [Project 1 - Authorization Validation](#24-project-1---authorization-validation)
25. [Project 1 - Group Policy Security Auditing](#25-project-1---group-policy-security-auditing)
26. [Authentication Investigation - 4624 and 4625](#26-authentication-investigation---4624-and-4625)
27. [Identity Change Auditing - 4720, 4726, 4728, 4729](#27-identity-change-auditing---4720-4726-4728-4729)
28. [Process and PowerShell Telemetry - 4688 and 4104](#28-process-and-powershell-telemetry---4688-and-4104)
29. [Enterprise Security Hardening](#29-enterprise-security-hardening)
30. [Privileged Access Review](#30-privileged-access-review)
31. [Password and Lockout Policy Review](#31-password-and-lockout-policy-review)
32. [Windows Firewall Review](#32-windows-firewall-review)
33. [SMB Security Review](#33-smb-security-review)
34. [Security Principles You Should Be Able to Explain](#34-security-principles-you-should-be-able-to-explain)
35. [Troubleshooting Lessons](#35-troubleshooting-lessons)
36. [Command Reference](#36-command-reference)
37. [Event ID Cheat Sheet](#37-event-id-cheat-sheet)
38. [Important Corrections and Refinements](#38-important-corrections-and-refinements)
39. [Project 1 Architecture From Memory](#39-project-1-architecture-from-memory)
40. [How to Explain Project 1 in an Interview](#40-how-to-explain-project-1-in-an-interview)
41. [Master Review Questions](#41-master-review-questions)
42. [Mastery Checklist](#42-mastery-checklist)

---

# 1. The Big Picture

The progression of the first part of the cybersecurity journey was intentionally broad before becoming deeply focused on Active Directory.

The sequence was approximately:

```text
Cybersecurity fundamentals
        ↓
Networking
        ↓
Packets / protocols / OSI
        ↓
Wireshark
        ↓
Windows internals
        ↓
Windows networking / firewalls
        ↓
Windows logs / PowerShell
        ↓
Enterprise Windows concepts
        ↓
Active Directory theory
        ↓
Kerberos / LDAP / DNS / Group Policy
        ↓
Windows Server
        ↓
Build a Domain Controller
        ↓
Build identities / groups / permissions
        ↓
Join a Windows 11 client
        ↓
Validate authentication and authorization
        ↓
Enable security auditing
        ↓
Investigate authentication and identity changes
        ↓
Add PowerShell telemetry
        ↓
Assess and harden the environment
        ↓
Package Project 1
```

The most important overall idea is:

> **Cybersecurity is not just attacking systems. It is understanding systems, identities, networks, permissions, normal behavior, telemetry, and security controls well enough to protect or assess them intelligently.**

The Active Directory project was chosen first because attacking an enterprise environment without understanding how identity, DNS, authentication, authorization, Group Policy, and resources normally work would make later offensive work shallow.

---

# 2. Cybersecurity Foundations

## What is cybersecurity?

The early notes defined cybersecurity as the techniques and practices used to secure:

- networks
- data
- computer systems

from unauthorized digital access or harm.

Attackers attempt to gain unauthorized access, execute malicious code, steal credentials, disrupt services, manipulate data, or abuse legitimate functionality.

Defenders attempt to prevent, detect, investigate, contain, and recover from those actions.

## CIA Triad

The CIA Triad is one of the first mental models learned.

### Confidentiality

**Confidentiality** means keeping information secret from people or systems that are not authorized to see it.

Questions to ask:

- Who should be allowed to read this?
- Can an unauthorized person intercept it?
- Is sensitive data encrypted?
- Are permissions too broad?

Examples connected to later work:

- Alice HR should not be able to read Finance data.
- HTTPS helps protect web traffic from passive interception.
- NTFS/SMB authorization helps keep departmental files confidential.

### Integrity

**Integrity** means maintaining the accuracy, authenticity, and trustworthiness of information.

Questions:

- Has the data been modified?
- Was a configuration changed without authorization?
- Can we prove communication was not tampered with?

Later connections:

- SMB signing protects the integrity of SMB communication.
- Audit logs help show who changed an account or group.
- Hashing can be used as part of integrity verification.

### Availability

**Availability** means systems and data are accessible to authorized users when needed.

Threat examples:

- denial-of-service attacks
- server outages
- failed infrastructure
- DNS failure
- broken authentication services

Later Active Directory example:

A perfectly secured Domain Controller that is unavailable cannot authenticate users or provide critical domain services.

## Attacker vs defender thinking

A useful distinction throughout the course:

### Attacker questions

- What is exposed?
- What can I reach?
- What identities exist?
- What permissions do I have?
- What is misconfigured?
- What can be abused?
- Can I obtain more privilege?
- Can I move to another system?

### Defender questions

- What should exist?
- What should normal activity look like?
- What controls reduce risk?
- What telemetry will show abuse?
- Which events prove something happened?
- How do I detect deviation?
- How do I remediate safely?
- Did the fix actually work?

Both sides require understanding the underlying system.

---

# 3. Networking Foundations

## The Internet

The internet is fundamentally a network of networks. Devices exchange data using agreed protocols.

The early notes used a simplified idea: two computers connected through networking infrastructure can communicate if they know how to address and route traffic to each other.

## IP address

An **IP address** identifies a host/network interface for Internet Protocol communication.

Example IPv4 format:

```text
192.168.1.10
```

An IP address is often compared to an address used to locate a device.

## IPv4 vs IPv6

### IPv4

- 32-bit addressing
- four decimal octets
- example: `192.168.1.10`
- approximately 4.3 billion possible addresses

### IPv6

- 128-bit addressing
- vastly larger address space
- introduced in part because IPv4 address space is limited

## Static vs dynamic addressing

### Dynamic IP

Usually supplied automatically, commonly through DHCP.

The address may change.

### Static IP

Configured to remain consistent.

This became critical in the AD project because the Domain Controller and DNS server needed a predictable address.

## DHCP

**DHCP - Dynamic Host Configuration Protocol**

DHCP automatically gives clients network configuration such as:

- IP address
- subnet mask/prefix
- default gateway
- DNS server information

### DHCP reservation

A reservation associates a specific client, commonly by MAC address, with a predictable address.

The notes used printers as an example of devices that may benefit from consistent addresses.

## Router

A router connects networks and forwards traffic between them.

The **default gateway** is typically the router a host sends traffic to when the destination is not on its own directly connected network.

## MAC address

A MAC address identifies a network interface at the local data-link level.

It is especially relevant for local network communication, ARP, switching, and DHCP reservations.

## Earlier referenced foundations

By Day 9, the notes explicitly said that the following had already been studied:

- ports
- TCP/UDP
- packets
- ARP
- DHCP
- NAT
- `netstat`
- Nmap

Those are therefore part of the expected foundation even though every original early-day PDF was not directly retrievable for this consolidation.

### ARP

**ARP - Address Resolution Protocol**

Conceptually:

```text
I know the local IPv4 address.
Which MAC address should receive the Ethernet frame?
```

ARP helps map a local IPv4 address to a MAC address.

### NAT

**NAT - Network Address Translation**

Common home networks use private internal addresses while the router translates traffic to/from a public address.

This helps multiple internal devices share public connectivity.

### Ports

A port helps distinguish network services on a host.

An IP address identifies a host/interface; a port helps identify a service endpoint.

Examples encountered later:

- DNS: 53
- Kerberos: 88
- LDAP: 389
- SMB: 445

Important:

> **An open port is not automatically a vulnerability.**

It means a network service appears reachable. Security analysis comes afterward.

---

# 4. OSI Model, TCP, UDP, and Packets

## OSI Model

The seven layers learned were:

| Layer | Name | Core idea |
|---|---|---|
| 7 | Application | Network-facing application protocols such as HTTP, HTTPS, DNS, FTP, SNMP |
| 6 | Presentation | Representation/translation, encoding, encryption-related presentation functions |
| 5 | Session | Session/connection management concepts |
| 4 | Transport | TCP/UDP, ports, delivery behavior |
| 3 | Network | IP addressing and routing |
| 2 | Data Link | MAC addressing and local delivery |
| 1 | Physical | Electrical, radio, cable, Wi-Fi signaling |

Do not treat the OSI model as seven unrelated definitions. It is a mental model for understanding where networking responsibilities occur.

## TCP

**TCP - Transmission Control Protocol**

Main characteristics studied:

- connection-oriented
- reliable
- ordered delivery
- acknowledgment/retransmission behavior
- more overhead than UDP

Why websites commonly use TCP:

Web data should arrive accurately and in the correct order.

## UDP

**UDP - User Datagram Protocol**

Main characteristics:

- connectionless
- lower overhead
- fast
- no guarantee of delivery
- no guarantee of ordering

Why games often use UDP:

Real-time applications frequently prefer speed and low latency over waiting to retransmit every lost packet.

## Packet thinking

The notes emphasized thinking in terms of data moving in packets.

Information discussed in packet/header context included:

- source IP
- destination IP
- protocol
- source/destination ports depending on layer/protocol
- sequence information for TCP
- checksums
- payload/data

### Payload

The payload is the actual data being carried.

### Header

The header contains metadata required for delivery and protocol processing.

---

# 5. DNS, HTTP, HTTPS, TLS, Ping, and Routing

# DNS

**DNS - Domain Name System**

Basic purpose:

```text
Human-readable name
        ↓
DNS
        ↓
IP address
```

Humans prefer names such as:

```text
google.com
```

Computers ultimately need addressing information.

## Simplified DNS lookup hierarchy

The early notes discussed four roles:

1. DNS recursor/resolver
2. root nameserver
3. TLD nameserver
4. authoritative nameserver

### Recursive DNS

A recursive resolver does lookup work on behalf of the client.

The client effectively asks:

> What address belongs to this name?

The resolver finds or retrieves the answer and returns it.

### DNS caching

DNS results can be cached temporarily so that the full lookup process does not need to occur every time.

### Authoritative answer

Comes from a server authoritative for that DNS data.

### Non-authoritative answer

Can come from cache or another recursive source rather than directly from the authoritative source.

## What happens if DNS fails?

A machine may still have IP connectivity while name-based communication fails.

This became one of the single most important lessons in the Active Directory project:

> **Ping by IP can work while Active Directory still fails because AD depends heavily on DNS-based service discovery.**

## Useful DNS command

```powershell
nslookup google.com
```

Later AD examples:

```powershell
nslookup kevinlab.local
nslookup SRV-DC01.kevinlab.local
```

---

## HTTP vs HTTPS

### HTTP

Protocol used for transferring web content.

### HTTPS

HTTP protected using TLS.

The key lesson:

> The `S` means the web communication is protected by encryption/authentication mechanisms supplied through TLS.

The early notes discussed public/private-key concepts in HTTPS/TLS.

## TLS Client Hello

Wireshark work introduced the **TLS Client Hello**.

It is an early message from the client during TLS negotiation and begins the process of establishing a protected TLS connection.

---

## Ping

`ping` checks whether a destination responds to ICMP echo requests and can help measure round-trip time.

Windows example:

```powershell
ping google.com
```

Important refinement:

> **No ping response does not prove a host is offline.**

A firewall can block ICMP while other services remain reachable.

## Latency

Latency was treated as round-trip delay - how long a request/response takes.

## Traceroute / tracert

Windows:

```powershell
tracert google.com
```

Purpose:

See the path/hops traffic takes toward a destination.

## Routing table

Day 9 used:

```powershell
route print
```

A routing table tells the host where to send traffic.

### Default route

The fallback route when no more-specific route matches.

### `0.0.0.0/0`

Conceptually represents all IPv4 destinations and is commonly used for a default route.

---

# 6. Wireshark and Packet Analysis

Wireshark was introduced as a packet-capture and protocol-analysis tool.

Basic workflow:

```text
Start capture
    ↓
Generate normal network activity
    ↓
Stop capture
    ↓
Filter traffic
    ↓
Inspect packets
```

Traffic was generated by browsing sites, using applications, and normal network activity.

Filters practiced included:

```text
dns
http
tcp
udp
```

and host filtering such as:

```text
ip.addr == YOUR_IP
```

## Why Wireshark matters

Wireshark helps answer:

- Which hosts communicated?
- Which protocols were used?
- Which ports were involved?
- Was DNS successful?
- Did a TCP connection form?
- What TLS negotiation occurred?
- What data is visible at packet level?

## Security mindset

Packet analysis gives evidence that complements host logs.

Later defensive correlation used common fields such as:

- timestamps
- IP addresses
- usernames
- hostnames
- process names
- ports

---

# 7. Windows Internals

Day 8 moved from networking into how Windows actually executes programs.

## What happens when a Windows program launches?

The notes described a simplified sequence:

1. Windows receives a request to execute a file.
2. The executable is located on disk.
3. Windows checks relevant conditions such as permissions/trust/architecture.
4. The Windows loader prepares the executable.
5. Required memory is allocated.
6. Required DLLs are loaded/mapped.
7. Windows creates a process.
8. At least one thread begins execution.
9. The CPU fetches, decodes, and executes instructions.
10. Programs request privileged OS functionality through system calls.
11. The kernel mediates access to hardware/resources.
12. When the program exits, threads/process resources are cleaned up.

## Process

A **process** is a running instance of a program.

Properties discussed included:

- PID
- virtual memory/address space
- security token
- handles
- environment variables
- one or more threads

Example:

```text
chrome.exe → PID 5124
```

## Thread

A thread is an execution path within a process.

A process can contain multiple threads.

## DLL

**DLL - Dynamic Link Library**

Windows programs can load shared libraries such as:

- `kernel32.dll`
- `user32.dll`

## Windows kernel

The Windows kernel is the privileged core that manages access to:

- CPU
- memory
- devices
- files
- hardware
- process scheduling and core OS resources

Applications do not safely access all hardware directly. They request OS services.

## User mode vs kernel mode

### User mode

Where ordinary applications run with restrictions.

Examples:

- browsers
- Discord
- Spotify
- Word
- most applications

They cannot freely access all kernel memory or directly control all hardware.

### Kernel mode

Highly privileged execution context for the Windows kernel and drivers.

Kernel-mode code can access critical system resources.

Security significance:

A bug or malicious action in kernel mode can have much greater impact than an ordinary user-mode process.

## Process Explorer

Process Explorer was used to inspect:

- browser processes
- Discord
- `explorer.exe`
- `svchost.exe`

## `svchost.exe`

**Service Host**

A Windows process used to host Windows services.

Why multiple `svchost.exe` processes exist:

- isolation
- stability
- security boundaries
- resource management

The basic lesson was not to assume that many `svchost.exe` processes are automatically suspicious.

---

# 8. Windows Networking and Firewall Foundations

Day 9 examined Windows networking more deeply.

## `ipconfig /all`

Rather than just copying the IPv4 address, the goal was to understand fields.

Examples:

- Host Name
- Node Type
- IP Routing Enabled
- WINS Proxy Enabled
- adapter state
- adapter description
- physical/MAC address
- DHCP Enabled
- Autoconfiguration Enabled
- DNS suffix
- IPv6 addresses
- IPv4 address
- gateway
- DNS servers

### IP Routing Enabled: No

Means the workstation is not acting as an IP router forwarding packets between networks.

### WINS

WINS is a legacy Windows name-resolution technology and is much less important in modern environments.

### Link-local IPv6

Used for local-link communication and not normally routed across the broader internet.

### Temporary IPv6 address

Windows can use temporary IPv6 addresses for privacy.

---

## Windows Firewall

Open:

```text
wf.msc
```

A firewall controls allowed/blocked network traffic according to rules.

### Inbound

Traffic arriving at the system.

### Outbound

Traffic initiated/sent by the system.

Later the project revisited Domain, Private, and Public firewall profiles.

The important concept:

> Do not disable the firewall as a first-line troubleshooting strategy. Determine which traffic/rule is actually required.

---

# 9. Windows Security Logging and Detection

## Event Viewer

Launch:

```text
eventvwr.msc
```

Windows stores events in different logs/channels.

Important distinction learned later:

> **The Security log is a log channel. "Audit Logon" is an audit-policy category/subcategory. They are not the same thing.**

## Windows auditing

Windows auditing records security-relevant activity so administrators and security analysts can investigate what occurred.

Examples:

- authentication
- process creation
- account management
- group changes
- PowerShell activity

## Key logon events

### 4624

Successful logon.

### 4625

Failed logon.

## Logon types encountered

### Type 2 - Interactive

Local interactive sign-in using the console.

### Type 3 - Network

Network-based access.

### Type 5 - Service

A service logon.

### Type 7 - Unlock

Unlocking a previously locked Windows session.

### Type 10 - RemoteInteractive

Commonly associated with Remote Desktop / Terminal Services interactive logon.

### Type 11 - CachedInteractive

Interactive logon using cached domain credentials.

Do not memorize only the number. Always interpret the event in context.

## 4688

**A new process has been created.**

Useful for determining that a process launched.

Examples:

- PowerShell
- Command Prompt
- browser
- Notepad
- Calculator

---

# 10. PowerShell Foundations

PowerShell became both an administration tool and an investigation tool.

## Service enumeration

```powershell
Get-Service
```

List services.

```powershell
Get-Service | Sort-Object Status
```

Sort service objects by status.

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

Filter to running services.

## Process enumeration

```powershell
Get-Process
```

## Network connections

```powershell
Get-NetTCPConnection
```

## Identity

```powershell
whoami
```

```powershell
whoami /groups
```

## Local administrators

```powershell
net localgroup administrators
```

## Users

```powershell
net user
```

## Files/directories

```powershell
Get-ChildItem C:\Users
Get-ChildItem C:\Windows\Temp
```

## Event logs - early method

```powershell
Get-EventLog -LogName Security -Newest 20
```

The project later moved toward `Get-WinEvent`.

## Why PowerShell matters

PowerShell can:

- administer Windows
- retrieve system state
- manage AD
- filter events
- automate repeatable work
- export results
- scale investigations
- query many objects more consistently than manual GUI work

The project also taught the downside:

> PowerShell is powerful and trusted, so attackers may abuse it. That makes PowerShell telemetry valuable to defenders.

---

# 11. Windows Server and Enterprise Roles

## Windows Server is not the same as Active Directory

One of the important Day 21 distinctions:

> **Windows Server is an operating system. AD DS is one server role.**

## Server role

A role is a function a Windows Server is configured to provide.

Roles studied included:

- Active Directory Domain Services
- DNS Server
- DHCP Server
- File and Storage Services
- Web Server (IIS)
- Print Server
- Remote Desktop Services
- Hyper-V

## Why split server roles?

Role separation can improve:

- security
- maintainability
- efficiency
- clarity
- troubleshooting

A real enterprise may use multiple servers rather than putting everything on one machine.

## Enterprise relationship

Example:

```text
Employee workstation
        ↓
DNS locates services
        ↓
AD DS authenticates identity
        ↓
Group Policy configures the system
        ↓
File Services provides resources
```

Different server roles cooperate to deliver the user's working environment.

---

# 12. Active Directory Foundations

## What is Active Directory?

Active Directory is Microsoft's centralized directory and identity-management system used to manage:

- users
- computers
- servers
- groups
- permissions
- organizational structure
- security policies

The problem it solves is **centralized management at scale**.

Without centralized directory services, every system could require separately managed accounts, passwords, permissions, and configuration.

## Domain

A domain is a centrally managed Windows identity/security environment.

Lab:

```text
kevinlab.local
```

## Domain Controller

A Domain Controller is a Windows Server running AD DS and providing domain identity services.

It is involved in:

- authentication
- directory data
- computer identities
- group membership
- policy
- Kerberos
- domain operations

## AD objects

Objects discussed included:

- users
- computers
- groups
- OUs

### User object

Represents a user identity.

### Computer object

Represents a domain-joined computer identity.

This matters because Active Directory does not only answer:

> Who is this user?

It also tracks:

> Is this computer part of the organization/domain?

### Group

Groups simplify management by applying access to sets of identities.

### OU - Organizational Unit

A container used to organize objects for administration and policy targeting.

Important distinction:

> Default AD containers such as `Users` and `Computers` are not identical to OUs. OUs are particularly useful because Group Policy can be linked to them.

---

# 13. AD Forests, Trees, Schema, Global Catalog, and Trusts

## Forest

The forest is the highest-level AD structure discussed.

A forest can contain one or more domains and shares important directory components.

## Schema

The schema defines the kinds of objects and attributes that can exist in AD.

Conceptual user attributes might include:

- username
- email
- identifiers
- other account properties

Schema changes are extremely powerful because they affect the directory's object model.

## Global Catalog

Provides searchable information about objects across a forest.

## Trust relationships

Trusts allow identities/resources across domains to establish controlled relationships.

The early notes described automatic trust relationships within a forest.

## Tree

An AD tree is a set of domains in a continuous namespace.

Example concept:

```text
company.com
├── hr.company.com
├── sales.company.com
└── japan.company.com
```

---

# 14. DNS Inside Active Directory

This is one of the most important areas of the entire project.

## Why AD needs DNS

AD clients need to locate:

- Domain Controllers
- Kerberos services
- LDAP services
- Global Catalog services

The client should not merely know an arbitrary DC IP manually. It uses DNS records to discover services.

## SRV records

**SRV - Service record**

An SRV record tells a client:

- what service exists
- what server provides it
- which port the service uses

Important AD example:

```text
_ldap._tcp.dc._msdcs.kevinlab.local
```

This is associated with locating LDAP-capable Domain Controllers for the domain.

## Why CLIENT01 needed SRV-DC01 as DNS

The initial CLIENT01 configuration pointed at the home router for DNS.

Basic network access could work, but AD discovery failed.

After setting the preferred DNS server to the Domain Controller, AD DNS resolution/service discovery worked.

This produced a foundational troubleshooting lesson:

```text
Network connectivity
        ≠
Correct Active Directory DNS
```

## Useful commands

```powershell
ipconfig /all
```

See DNS configuration.

```powershell
ipconfig /flushdns
```

Clear cached DNS resolver entries.

```powershell
ipconfig /registerdns
```

Request DNS registration.

```powershell
nslookup kevinlab.local
```

Test domain name resolution.

```powershell
nslookup SRV-DC01.kevinlab.local
```

Test host resolution.

```powershell
nltest /dsgetdc:kevinlab.local
```

Locate a Domain Controller for the domain.

Important later correction:

> `nltest /dsgetdc` helps discover a DC. It does **not** by itself prove which DC authenticated the current user session.

---

# 15. Kerberos, NTLM, Authentication, and Authorization

# Authentication

Authentication answers:

> **Who are you? Can you prove that identity?**

# Authorization

Authorization answers:

> **Now that I know who you are, what are you allowed to access or do?**

This distinction was repeatedly demonstrated in the lab:

Alice could authenticate successfully to the domain but still be denied the Finance share.

That means:

```text
Authentication = successful
Authorization = denied for Finance
```

## Kerberos

Kerberos is the primary ticket-based authentication protocol studied for Active Directory.

The important conceptual flow:

```text
User enters credentials
        ↓
Client locates Domain Controller using DNS
        ↓
Kerberos/KDC verifies identity
        ↓
Ticket Granting Ticket (TGT)
        ↓
User requests access to a service
        ↓
Service ticket
        ↓
Service accepts ticket
        ↓
Access evaluated
```

## KDC

**KDC - Key Distribution Center**

The Domain Controller provides Kerberos KDC functionality.

## TGT

**Ticket Granting Ticket**

Represents that the identity has been authenticated and can request tickets for services.

## Service ticket

A ticket intended for a specific service.

## Why tickets?

The goal is to avoid repeatedly sending the user's password across the network every time a resource is requested.

## `klist`

Used on CLIENT01 to inspect Kerberos tickets.

A `krbtgt` ticket was observed as part of the authentication evidence.

## NTLM

NTLM is an older Windows authentication protocol.

The notes introduced it as challenge-response authentication based on credential-derived material rather than sending the plaintext password directly.

Kerberos is normally preferred in an AD domain when conditions support it.

## Password attacks introduced

### Brute force

Trying many passwords against an account.

### Password spraying

Trying a small number of common passwords across many accounts.

Why this matters:

It may avoid rapidly locking a single account while testing many identities.

### Credential stuffing

Using username/password combinations leaked from another service.

### Phishing

Tricking users into revealing credentials or performing harmful actions.

## Kerberoasting - conceptual introduction

The notes introduced Kerberoasting at a high level:

1. attacker obtains a domain user context
2. identifies service accounts/SPNs
3. requests Kerberos service tickets
4. obtains ticket material
5. attempts offline cracking against the service account secret

At this stage it was theory, not yet the later controlled AD-attack project.

---

# 16. LDAP and Directory Queries

**LDAP - Lightweight Directory Access Protocol**

LDAP is used to communicate with directory services.

Active Directory stores/queryable information such as:

- users
- computers
- groups
- OUs
- attributes
- security-related directory information

A useful mental model:

> Kerberos primarily answers identity/authentication questions; LDAP is heavily associated with querying directory information.

This is simplified but useful at the current learning stage.

---

# 17. Group Policy

## Group Policy

Group Policy is the Windows/AD management framework used to centrally configure users and computers.

## GPO

**GPO - Group Policy Object**

A GPO is a collection of settings.

The distinction:

```text
Group Policy = management framework/system
GPO = package of settings
```

## Where GPOs can be linked

The notes covered:

- Sites
- Domains
- OUs

The lab primarily used OU targeting.

## Examples of settings

- password policies
- account lockout
- firewall rules
- Defender settings
- USB/removable-device controls
- software restrictions
- Windows Update
- scripts
- desktop settings
- mapped resources
- PowerShell restrictions/logging

## Why GPO matters

Without centralized policy, an administrator might need to configure thousands of endpoints manually.

GPO allows:

```text
Create policy once
        ↓
Link to organizational scope
        ↓
Many systems/users receive configuration
```

## `gpupdate /force`

Forces immediate reprocessing of Group Policy rather than waiting for normal refresh.

## `gpresult /r`

Shows Resultant Set of Policy information in summary form, including applied GPOs.

Used to verify that the intended security GPO actually reached the machine.

## STIG

The notes introduced **STIG - Security Technical Implementation Guide** as a federal-security connection: a security configuration guide/checklist for technology.

---

# 18. SMB, NTFS, and Enterprise File Access

## SMB

**SMB - Server Message Block**

Used for Windows network file sharing and other shared-resource communication.

Lab examples:

```text
\\SRV-DC01\HR
\\SRV-DC01\Finance
\\SRV-DC01\Sales
\\SRV-DC01\IT
```

## NTFS

Windows filesystem with permissions such as:

- Read
- Write
- Execute
- Modify

## Share permissions vs NTFS permissions

### Share permissions

Control access when the resource is accessed through SMB/network sharing.

### NTFS permissions

Control filesystem access to the folder/files themselves.

Key lesson:

> Effective network access depends on both layers.

A good administrator/security analyst should not troubleshoot SMB access by looking at only one permission layer.

---

# 19. AGDLP and Role-Based Access

One of the most important enterprise authorization patterns learned was **AGDLP**:

```text
A = Account
G = Global Group
DL = Domain Local Group
P = Permission
```

Flow:

```text
User Account
        ↓
Global Group
        ↓
Domain Local Group
        ↓
Resource Permission
```

Lab example:

```text
Alice HR (ahr)
        ↓
GG_HR_Users
        ↓
DL_HR_Share_Modify
        ↓
HR folder/share permission
```

## Why not assign permissions directly to Alice?

Direct user-by-user permissions become difficult to maintain.

Better:

- Global groups describe role/identity membership.
- Domain Local groups describe access to a resource.
- Permissions are attached to the resource-oriented group.

This creates scalable administration.

## Group scopes introduced

- Global
- Domain Local
- Universal

The project primarily used:

- Global Security Groups for departmental role membership
- Domain Local Security Groups for resource permission mapping

---

# 20. VMware and Lab Architecture

## VMware Workstation

Used to build isolated virtual systems.

## VMnet

VMware virtual networking connects VMs to:

- one another
- host
- internet
- physical network

depending on configuration.

## Why isolated labs matter

A lab gives a controlled environment for:

- Windows administration
- Active Directory
- security testing
- malware-analysis concepts
- future penetration-testing work

without intentionally touching production systems.

## Snapshots

Snapshots provided rollback points before important changes.

Important lesson:

> Before risky configuration changes, preserve a known-good state.

Snapshots used during the project included baseline/domain-joined/final known-good states.

---

# 21. Project 1 - Building the Domain Controller

# Lab systems

```text
Domain: kevinlab.local

SRV-DC01
- Windows Server 2022
- Domain Controller
- AD DS
- DNS
- Group Policy
- SMB/File Services
- Windows Security Auditing

CLIENT01
- Windows 11
- Domain joined
- workstation/client
```

Historical IP addresses changed during the lab. Early notes show `192.168.1.236`, while later work used `192.168.1.196`.

**Do not memorize the number. Memorize the reason the DC must have stable addressing and clients must use AD-aware DNS.**

## Pre-flight commands

```powershell
hostname
ipconfig /all
Get-NetAdapter
Get-NetIPAddress -AddressFamily IPv4
```

## Why static IP for a DC?

Clients need to reliably locate services such as:

- DNS
- Kerberos
- LDAP
- authentication
- Group Policy
- domain services

A Domain Controller/DNS server changing address unpredictably is a serious operational problem.

## Install AD DS

Server Manager:

```text
Manage
→ Add Roles and Features
→ Role-based or feature-based installation
→ Active Directory Domain Services
```

## Promotion

Promoting a normal Windows Server to a Domain Controller means it begins hosting/providing domain directory services.

The project created:

```text
New forest: kevinlab.local
Domain Controller: SRV-DC01
```

---

# 22. Project 1 - Active Directory Administration

After promotion, the first job was to prove the DC actually worked.

## Identity/system validation

```powershell
hostname
whoami
Get-ADDomain
Get-ADForest
Get-ADDomainController
```

Purpose:

- verify host identity
- verify current security context
- verify domain
- verify forest
- verify Domain Controller information

## Critical Domain Controller services

```powershell
Get-Service NTDS,DNS,KDC,Netlogon
```

### NTDS

Active Directory Domain Services core directory service.

### DNS

DNS Server service.

### KDC

Kerberos Key Distribution Center.

### Netlogon

Supports domain logon and secure-channel functions.

## DC diagnostics

```powershell
dcdiag /test:Advertising
dcdiag /test:DNS
```

### Advertising

Checks whether the DC is properly advertising its availability as a Domain Controller.

### DNS

Tests DNS health relevant to AD.

Both passed during the lab.

## AD administration tools

Important tools identified:

- Active Directory Users and Computers
- DNS
- Group Policy Management
- Active Directory Domains and Trusts
- Active Directory Sites and Services

## OU structure

Top level:

```text
KEVINLAB-Users
KEVINLAB-Computers
KEVINLAB-Groups
KEVINLAB-Servers
KEVINLAB-Disabled
```

Users:

```text
IT
HR
Finance
Sales
```

Computers:

```text
Workstations
Laptops
```

Groups:

```text
Security Groups
```

## Test users

```text
Kevin Admin   → kadmin
Alice HR      → ahr
Frank Finance → ffinance
Sam Sales     → ssales
```

## Global groups

```text
GG_IT_Admins
GG_HR_Users
GG_Finance_Users
GG_Sales_Users
```

Membership:

```text
kadmin   → GG_IT_Admins
ahr      → GG_HR_Users
ffinance → GG_Finance_Users
ssales   → GG_Sales_Users
```

## PowerShell verification

```powershell
Get-ADOrganizationalUnit -Filter * |
    Select-Object Name, DistinguishedName
```

```powershell
Get-ADUser -Filter * |
    Select-Object Name, SamAccountName, Enabled
```

```powershell
Get-ADGroup -Filter * |
    Select-Object Name, GroupScope, GroupCategory
```

```powershell
Get-ADGroupMember GG_HR_Users
```

## Important troubleshooting lesson

The GUI appeared to accept group membership, but later verification showed membership was missing.

PowerShell correction:

```powershell
Add-ADGroupMember -Identity "GroupName" -Members "Username"
```

Lesson:

> **Do not trust a click. Verify actual system state.**

## Domain Local groups

```text
DL_IT_Share_Modify
DL_HR_Share_Modify
DL_Finance_Share_Modify
DL_Sales_Share_Modify
```

Matching Global Groups were nested into matching Domain Local groups.

---

# 23. Project 1 - Building and Joining CLIENT01

## Windows 11 client

CLIENT01 represented an employee workstation.

Rename:

```powershell
Rename-Computer -NewName "CLIENT01" -Restart
```

Verify:

```powershell
hostname
whoami
ipconfig /all
```

## DNS troubleshooting

Initial problem:

CLIENT01 used the home-router DNS server.

Symptoms:

- basic connectivity worked
- AD/DNS service discovery failed

Fix:

- preferred DNS → SRV-DC01
- alternate left blank for the lab design

Then:

```powershell
ipconfig /flushdns
ipconfig /registerdns
nslookup kevinlab.local
```

## Discover DC

```powershell
nltest /dsgetdc:kevinlab.local
```

## Join domain

Conceptually performed with `Add-Computer` using domain credentials.

Example pattern:

```powershell
Add-Computer -DomainName "kevinlab.local" `
    -Credential "KEVINLAB\Administrator" `
    -Restart
```

## Verify domain membership

```powershell
Get-CimInstance Win32_ComputerSystem |
    Select-Object Name,Domain,PartOfDomain
```

Expected concept:

```text
CLIENT01
kevinlab.local
True
```

## Computer object placement

CLIENT01 was moved into the `Workstations` OU so that workstation-targeted Group Policy could be applied cleanly.

## Domain login

Alice (`ahr`) was used as a domain user.

Useful verification:

```powershell
whoami
hostname
$env:LOGONSERVER
```

`$env:LOGONSERVER` returned `SRV-DC01` in the lab.

## Kerberos tickets

```powershell
klist
```

Used to inspect tickets and confirm Kerberos activity.

## Group Policy

```powershell
gpresult /r
```

Used to verify domain policy processing.

## Secure channel

```powershell
Test-ComputerSecureChannel -Verbose
```

and:

```powershell
nltest /sc_verify:kevinlab.local
```

Used to validate the computer-domain trust/secure channel.

---

# 24. Project 1 - Authorization Validation

The lab deliberately tested both success and failure.

## Alice HR

Expected:

```text
\\SRV-DC01\HR
→ Allowed
```

Expected:

```text
\\SRV-DC01\Finance
→ Denied
```

## Frank Finance

Expected:

```text
\\SRV-DC01\Finance
→ Allowed
```

Expected:

```text
\\SRV-DC01\HR
→ Denied
```

This proves more than "the share works."

It demonstrates:

- user authentication
- group membership
- AGDLP mapping
- SMB sharing
- NTFS/share authorization
- least privilege
- denial of cross-department access

---

# 25. Project 1 - Group Policy Security Auditing

A security-focused workstation GPO was created:

```text
GPO-Workstation-Security-Auditing
```

Linked to the workstation scope/OU.

One key setting:

```text
Advanced Audit Policy
→ Detailed Tracking
→ Audit Process Creation
→ Success
```

Apply:

```powershell
gpupdate /force
```

Verify:

```powershell
gpresult /r
```

Generate known activity:

- Notepad
- Calculator
- `whoami`

Then Event Viewer:

```text
Windows Logs
→ Security
→ filter Event ID 4688
```

This was the transition from:

> "I configured Windows"

to:

> "I can generate and investigate Windows security telemetry."

---

# 26. Authentication Investigation - 4624 and 4625

## Controlled test

Alice HR was used to intentionally generate:

- a failed logon
- a successful logon

## Failed event

Lab record:

```text
Timestamp: 8/9/2026 5:48:41 PM
Event ID: 4625
Account: ahr
Logon Type: 2
Failure reason: unknown username or bad password
```

## Successful event

```text
Timestamp: 8/9/2026 5:48:58 PM
Event ID: 4624
Account: ahr
Domain: KEVINLAB
Computer: CLIENT01
Logon Type observed: 11
```

## Why compare CLIENT01 and SRV-DC01?

Different systems can record different evidence because:

- the action occurs on different machines
- different services process different parts of the activity
- different audit policy is enabled
- the workstation and DC have different roles

Security lesson:

> **An Event ID without system context is incomplete.**

## PowerShell retrieval

```powershell
Get-WinEvent -LogName Security
```

Most recent:

```powershell
Get-WinEvent -LogName Security -MaxEvents 10
```

Filter IDs:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    ID=4624,4625
} -MaxEvents 10
```

## Why PowerShell over manual Event Viewer?

Event Viewer is useful for interactive inspection.

PowerShell becomes more valuable for:

- repeatability
- filtering
- automation
- export
- large datasets
- scripting
- consistent triage

---

# 27. Identity Change Auditing - 4720, 4726, 4728, 4729

A separate Domain Controller auditing GPO was created:

```text
GPO-DomainController-Security-Auditing
```

Linked to the Domain Controllers OU.

Advanced Audit Policy:

```text
Account Management
→ Audit User Account Management
→ Success

Account Management
→ Audit Security Group Management
→ Success
```

## Controlled account lifecycle

Temporary account:

```text
audittest
```

### 4720 - user created

```text
8/10/2026 11:28:19 AM
Actor: Administrator
Target: audittest
```

### 4728 - member added to security-enabled Global Group

```text
8/10/2026 11:29:04 AM
Actor: Administrator
Member/Target: audittest
Group: GG_HR_Users
```

### 4729 - member removed from security-enabled Global Group

```text
8/10/2026 11:32:34 AM
Actor: Administrator
Member/Target: audittest
Group: GG_HR_Users
```

### 4726 - user deleted

```text
8/10/2026 11:33:14 AM
Actor: Administrator
Target: audittest
```

## Actor vs target

### Actor / Subject

The identity performing the action.

### Target / Member

The identity/object affected.

This distinction is critical during investigations.

## Query

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    ID=4720,4728,4729,4726
} -MaxEvents 30
```

Important refinement:

> 4728/4729 refer specifically to security-enabled **Global Group** membership changes. Other group scopes have different event IDs.

---

# 28. Process and PowerShell Telemetry - 4688 and 4104

## Visibility problem

Knowing:

```text
powershell.exe launched
```

is useful.

But the analyst often also wants:

> What did PowerShell actually execute?

## 4688

Process creation event.

Answers questions such as:

- Did PowerShell start?
- What executable ran?
- What parent/process context existed?
- What command line was used, **if command-line auditing was separately enabled**?

## Command-line visibility

Additional policy was enabled so 4688 could include process command-line details.

Security concern:

Command-line arguments can contain sensitive information, so logging is powerful but must be handled appropriately.

## 4104

**PowerShell Script Block Logging**

Log location:

```text
Microsoft-Windows-PowerShell/Operational
```

4104 can record PowerShell script-block content.

## 4688 vs 4104

```text
4688
→ process-level visibility
→ "PowerShell started"

4104
→ PowerShell-language/content visibility
→ "This PowerShell content was processed"
```

They complement one another.

## Benign telemetry generated

Examples:

```powershell
whoami
```

```powershell
Get-Service | Select-Object -First 5
```

```powershell
$service = Get-Service
$service.Count
```

The point was not malicious activity. The point was to generate known evidence and validate logging.

---

# 29. Enterprise Security Hardening

Day 30 changed the question from:

> Can I see what happened?

to:

> How do I reduce the chance that bad activity succeeds in the first place?

## Detection vs prevention/hardening

### Detection / visibility

Provides evidence and awareness.

Examples:

- 4625
- 4688
- 4104
- identity-change events

### Hardening / prevention

Reduces weaknesses and unnecessary opportunities.

Examples:

- stronger password policy
- removing unnecessary privilege
- disabling legacy protocols
- firewall controls
- requiring SMB signing

## Hardening

Hardening means reducing weaknesses and unnecessary attack opportunities through secure configuration.

Conceptual flow:

```text
Default / functional system
        ↓
Assess exposure
        ↓
Remove unnecessary capability
        ↓
Restrict access
        ↓
Strengthen configuration
        ↓
Validate
        ↓
Hardened system
```

## Attack surface

The set of ways an attacker may interact with or potentially compromise a system.

Examples:

- services
- protocols
- accounts
- privileges
- applications
- network ports
- credentials
- remote-management paths

More functionality generally means more things that require security attention.

## Security baseline

A defined expected secure state.

Mental model:

```text
Expected secure configuration
        vs
Actual configuration
        ↓
Differences to assess
```

## Configuration drift

A system can become less aligned with its baseline over time.

Example:

```text
Day 1:
Firewall enabled
SMBv1 disabled
Only approved admins

Months later:
Temporary firewall exception remains
Temporary admin remains
Legacy protocol re-enabled
```

That is configuration drift.

## Change-control thinking

Before hardening:

1. identify current state
2. define desired state
3. explain risk
4. choose a justified change
5. consider operational impact
6. implement
7. verify
8. make sure required functionality still works

A "secure" change that destroys business functionality is not automatically a good operational change.

---

# 30. Privileged Access Review

Groups reviewed:

- Domain Admins
- Enterprise Admins
- Schema Admins
- Administrators

## Domain Admins

Highly privileged within the domain.

## Enterprise Admins

Highly privileged across the forest.

## Schema Admins

Can modify the AD schema.

## Administrators

Broad administrative control in its relevant Windows/domain context.

## Lab finding

Normal HR, Finance, and Sales users were not members of these privileged groups.

## Least privilege

An identity should receive only the access necessary for its responsibilities.

## Privilege separation

Ordinary daily-use identity and administrative identity should not be treated as interchangeable.

Example concept:

```text
Kevin ordinary account
≠
Kevin administrative account
```

Why?

A compromised daily account should not automatically give an attacker maximum administrative power.

---

# 31. Password and Lockout Policy Review

Initial domain policy observed:

```text
Minimum password length: 7
Complexity: Enabled
Password history: 24
Minimum password age: 1 day
Maximum password age: 42 days
Lockout threshold: 0
Lockout duration: Not defined
Reset counter: Not defined
```

## Minimum length

A 7-character minimum was identified as the lab's clearest hardening opportunity.

The lab increased it to:

```text
12 characters
```

## Complexity

Intended to reduce simple/predictable password choices.

## Password history

Remembering 24 previous passwords reduces immediate password reuse/cycling.

## Lockout threshold

`0` meant the account would not automatically lock after failed attempts.

The important security tradeoff:

Too permissive:
- repeated guesses can continue

Too aggressive:
- normal mistypes cause lockouts
- attackers may intentionally lock users out
- denial-of-service potential

## Review refinement

The original study notes treated periodic password changes as a simple way to keep passwords unpredictable. Treat that as **historical study context**, not a universal rule. Modern password guidance can vary by organization, standard, threat model, MFA deployment, and evidence of compromise.

What you should remember from the project is:

> **Evaluate password policy as a set of interacting controls rather than assuming "more restrictive = always better."**

---

# 32. Windows Firewall Review

Profiles:

- Domain
- Private
- Public

During the Day 30 review:

```text
CLIENT01 active profile: Domain
SRV-DC01 was observed showing Public
```

Firewall itself was enabled on both systems.

## Domain profile

Used when Windows recognizes the system as connected to its AD domain environment.

## Private profile

For trusted private networks.

## Public profile

More restrictive posture intended for untrusted/public networks.

## Inbound vs outbound

### Inbound

Connections/traffic coming into the system.

### Outbound

Connections/traffic the system initiates outward.

## Security lesson

Do not troubleshoot by simply disabling all firewall protection.

Instead determine:

- what service needs communication?
- which protocol?
- which port?
- which direction?
- which systems should be allowed?
- which profile/rule applies?

---

# 33. SMB Security Review

Command:

```powershell
Get-SmbServerConfiguration
```

Final relevant observations:

```text
EnableSMB1Protocol      = False
EnableSMB2Protocol      = True
EnableSecuritySignature = True
RequireSecuritySignature = True
```

## SMBv1

Legacy SMB protocol.

Disabled in the lab.

Security principle:

> Remove unnecessary legacy functionality when it is not required.

## SMBv2 / modern SMB family

The Windows configuration exposes an SMB2 setting that covers modern SMB protocol support, including later SMB family behavior such as SMB3.

## SMB signing

SMB signing acts like an integrity/authentication "seal" on SMB messages.

It helps protect against:

- tampering
- certain man-in-the-middle manipulation

The lab required signing.

---

# 34. Security Principles You Should Be Able to Explain

You should be able to define and connect all of these:

## Authentication

Prove identity.

## Authorization

Determine allowed actions/resources.

## Least privilege

Give only necessary privilege.

## Privilege separation

Separate ordinary and privileged contexts.

## Role-based access

Assign access according to role/group rather than individually.

## Centralized identity

Manage identities in a common directory.

## Centralized policy

Use Group Policy to configure many systems.

## Defense in depth

Use multiple security layers rather than relying on one control.

Example in the lab:

```text
Authentication
+ groups
+ NTFS
+ SMB permissions
+ firewall
+ auditing
+ PowerShell visibility
+ hardening
```

## Attack surface

All reachable/usable paths an attacker may interact with.

## Detection

Identify evidence or behavior.

## Prevention

Stop or reduce likelihood of unwanted behavior.

## Security baseline

Expected secure configuration.

## Configuration drift

Movement away from that expected state.

## Audit trail

Recorded evidence showing actions and actors.

## Change validation

Verify that a security change had the intended result and did not unnecessarily break legitimate functionality.

---

# 35. Troubleshooting Lessons

# Lesson 1 - DNS can break AD while basic networking works

Problem:

CLIENT01 could communicate at the IP level but used the home router for DNS.

Result:

AD service discovery did not work correctly.

Fix:

Use SRV-DC01 as DNS, refresh DNS state, validate resolution/discovery.

Lesson:

> **AD troubleshooting should make DNS one of the first checks.**

---

# Lesson 2 - GUI success is not proof

Problem:

Group membership appeared to be configured through the GUI but did not actually persist as expected.

Fix:

Verify with PowerShell and apply the membership explicitly.

Lesson:

```text
Configure
    ↓
Verify
    ↓
Test
```

---

# Lesson 3 - Different machines log different evidence

CLIENT01 and SRV-DC01 do not necessarily record identical events.

Why?

- workstation handles local/client activity
- DC handles directory/domain operations
- different policies apply
- different services participate

Lesson:

> Ask **where should this evidence logically exist?**

---

# Lesson 4 - GPOs must be verified

Creating a GPO does not prove the target applied it.

Use:

```powershell
gpupdate /force
gpresult /r
```

Then generate known activity and confirm expected logs.

---

# Lesson 5 - Secure channel matters

A domain-joined machine maintains a trust relationship/secure channel with the domain.

Use:

```powershell
Test-ComputerSecureChannel -Verbose
```

Troubleshooting domain membership should include trust/secure-channel health.

---

# Lesson 6 - Do not infer too much from one command

Example:

```powershell
nltest /dsgetdc:kevinlab.local
```

This proves/finds a discoverable DC.

It does not necessarily prove:

> "This exact DC authenticated this exact login event."

Use evidence appropriate to the question.

---

# 36. Command Reference

# Basic Windows/networking

```powershell
hostname
```

Show computer hostname.

```powershell
whoami
```

Show current security identity.

```powershell
whoami /groups
```

Show current token/group memberships.

```powershell
ipconfig
ipconfig /all
```

Show network configuration.

```powershell
ping <target>
```

Basic ICMP reachability/RTT test.

```powershell
tracert <target>
```

Trace path/hops.

```powershell
route print
```

Display routing table.

```powershell
nslookup <name>
```

Query DNS.

```powershell
wf.msc
```

Open Windows Defender Firewall with Advanced Security.

```powershell
eventvwr.msc
```

Open Event Viewer.

---

# Windows services/processes

```powershell
Get-Service
```

```powershell
Get-Service | Sort-Object Status
```

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"}
```

```powershell
Get-Process
```

```powershell
Get-NetTCPConnection
```

---

# Active Directory discovery/health

```powershell
Get-ADDomain
```

Current AD domain information.

```powershell
Get-ADForest
```

Forest information.

```powershell
Get-ADDomainController
```

DC information.

```powershell
Get-Service NTDS,DNS,KDC,Netlogon
```

Critical DC services.

```powershell
nltest /dsgetdc:kevinlab.local
```

Locate a DC.

```powershell
dcdiag /test:Advertising
```

DC advertising test.

```powershell
dcdiag /test:DNS
```

AD DNS diagnostic.

---

# AD object enumeration

```powershell
Get-ADOrganizationalUnit -Filter * |
    Select-Object Name,DistinguishedName
```

```powershell
Get-ADUser -Filter * |
    Select-Object Name,SamAccountName,Enabled
```

```powershell
Get-ADGroup -Filter * |
    Select-Object Name,GroupScope,GroupCategory
```

```powershell
Get-ADGroupMember GG_HR_Users
```

```powershell
Add-ADGroupMember -Identity "GroupName" -Members "Username"
```

---

# Client/domain membership

```powershell
Rename-Computer -NewName "CLIENT01" -Restart
```

```powershell
Add-Computer -DomainName "kevinlab.local" `
    -Credential "KEVINLAB\Administrator" `
    -Restart
```

```powershell
Get-CimInstance Win32_ComputerSystem |
    Select-Object Name,Domain,PartOfDomain
```

```powershell
Test-ComputerSecureChannel -Verbose
```

```powershell
$env:LOGONSERVER
```

```powershell
klist
```

---

# Group Policy

```powershell
gpupdate /force
```

```powershell
gpresult /r
```

---

# DNS client repair/refresh

```powershell
ipconfig /flushdns
```

```powershell
ipconfig /registerdns
```

---

# File/share setup

```powershell
New-Item -ItemType Directory `
    -Path "C:\Shares\Departments\HR" `
    -Force
```

```powershell
Get-ChildItem "C:\Shares\Departments"
```

```powershell
Get-SmbShare
```

```powershell
Get-SmbServerConfiguration
```

`New-SmbShare` was used during project file-sharing work to publish SMB shares.

---

# Event log investigation

```powershell
Get-WinEvent -LogName Security
```

```powershell
Get-WinEvent -LogName Security -MaxEvents 10
```

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    ID=4624,4625
} -MaxEvents 10
```

```powershell
Get-WinEvent -FilterHashtable @{
    LogName='Security'
    ID=4720,4728,4729,4726
} -MaxEvents 30
```

---

# Password policy

```powershell
Get-ADDefaultDomainPasswordPolicy
```

Useful selected view:

```powershell
Get-ADDefaultDomainPasswordPolicy |
    Select-Object MinPasswordLength,
                  ComplexityEnabled,
                  PasswordHistoryCount,
                  MinPasswordAge,
                  MaxPasswordAge,
                  LockoutThreshold
```

---

# Firewall review

```powershell
Get-NetFirewallProfile
```

---

# 37. Event ID Cheat Sheet

| Event ID | Meaning learned |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4688 | New process created |
| 4720 | User account created |
| 4726 | User account deleted |
| 4728 | Member added to a security-enabled Global Group |
| 4729 | Member removed from a security-enabled Global Group |
| 4104 | PowerShell Script Block Logging |

## Remember context, not just numbers

For every event ask:

```text
When?
Which computer?
Which log/channel?
Actor?
Target?
Account?
Logon type?
Process?
Group?
What does the event actually prove?
```

---

# 38. Important Corrections and Refinements

These are especially important because learning means improving earlier mental models.

## 1. `nltest /dsgetdc` does not prove the exact authentication DC

It locates/discovers a Domain Controller.

For the current logged-on session, `$env:LOGONSERVER` is more direct evidence of the logon server.

## 2. Security log vs audit policy

`Security` is an event-log channel.

`Audit Logon`, `Audit Process Creation`, `Audit User Account Management`, etc. are audit-policy settings/categories/subcategories.

Do not confuse where events are stored with what causes them to be audited.

## 3. 4688 vs 4104

4688:

```text
Process-level event
```

4104:

```text
PowerShell content/script-block telemetry
```

They answer different questions.

## 4. 4688 command-line data may require extra policy

Do not assume every 4688 automatically has full command-line arguments.

## 5. 4728/4729 are Global Group events

Do not apply them blindly to every AD group scope.

## 6. SMB2 configuration and SMB3

Windows' `EnableSMB2Protocol` configuration represents the modern SMB protocol family behavior; do not interpret the property as meaning "SMB3 does not exist."

## 7. Lab IP changed

Early notes:

```text
192.168.1.236
```

Later project work:

```text
192.168.1.196
```

The number is not the lesson.

The lesson is:

- stable DC addressing
- correct client DNS
- verify current state rather than copying old notes

## 8. Security settings have tradeoffs

Do not turn hardening into:

```text
Higher number = safer
Lower threshold = safer
More restrictive = always better
```

Ask:

- threat addressed?
- impact?
- usability?
- compatibility?
- denial-of-service risk?
- recovery?
- validation?

---

# 39. Project 1 Architecture From Memory

You should eventually be able to draw this without looking:

```text
                         kevinlab.local
                              |
                         SRV-DC01
                   Windows Server 2022
                              |
        +---------------------+---------------------+
        |                     |                     |
      AD DS                  DNS                  GPO
        |                     |                     |
    Identity             DC discovery          Policy
        |                                           |
        |                                           v
        |                                       CLIENT01
        |                                      Windows 11
        |                                      Domain joined
        |
        +------ Users / Computers / Groups
        |
        +------ GG_HR_Users
                    |
                    v
             DL_HR_Share_Modify
                    |
                    v
              \\SRV-DC01\HR

CLIENT01
   |
   +---- Kerberos authentication
   |
   +---- GPO processing
   |
   +---- SMB resource access
   |
   +---- Windows Security logs
   |
   +---- PowerShell Operational logs

Security telemetry:
4624 / 4625
4688
4720 / 4726
4728 / 4729
4104

Hardening:
Privileged access
Password policy
Firewall
SMBv1 disabled
SMB signing required
```

---

# 40. How to Explain Project 1 in an Interview

## 30-second version

> I built and secured an enterprise-style Active Directory lab using Windows Server 2022 and a Windows 11 domain client in VMware. I configured AD DS, DNS, OUs, users and groups, AGDLP-based access control, SMB/NTFS permissions, and Group Policy. I then enabled Windows security auditing and PowerShell logging, investigated authentication and identity-change events, and performed a hardening review covering privileged groups, password policy, firewall configuration, and SMB security.

## 2-3 minute structure

### 1. Why?

You wanted to understand how enterprise identity and Windows infrastructure actually work before trying to attack or defend them.

### 2. Architecture

- SRV-DC01
- kevinlab.local
- CLIENT01
- AD DNS
- department identities and shares

### 3. Identity design

- OUs
- users
- Global groups
- Domain Local groups
- AGDLP

### 4. Authorization

Demonstrate:

```text
Alice → HR allowed
Alice → Finance denied
```

### 5. Policy and telemetry

- workstation auditing GPO
- DC auditing GPO
- 4624/4625
- 4688
- 4720/4726
- 4728/4729
- 4104

### 6. Hardening

- privilege review
- password minimum increased
- firewall reviewed
- SMBv1 disabled
- SMB signing required

### 7. Troubleshooting

Best example:

> CLIENT01 initially used the router for DNS, which caused AD discovery problems. I corrected the client DNS configuration to use the Domain Controller and validated resolution/domain discovery afterward.

### 8. What you learned

Identity is central:

```text
Who are you?
→ Authentication

What can you do?
→ Authorization

Which computer belongs to the organization?
→ Computer identity

Who gets Finance?
→ Group membership

How should endpoints behave?
→ Group Policy

What happened?
→ Audit telemetry

How do we reduce exposure?
→ Hardening
```

---

# 41. Master Review Questions

Use these without notes. If you cannot answer one, return to the relevant section.

## Cybersecurity fundamentals

1. What are confidentiality, integrity, and availability?
2. Give one real control or failure example for each part of the CIA Triad.
3. What is the difference between an attacker question and a defender question?
4. Why is "system works" not the same as "system is secure"?

## Networking

5. What problem does an IP address solve?
6. What is the difference between IPv4 and IPv6?
7. Why would a server use a static IP?
8. What does DHCP provide?
9. What is a default gateway?
10. What does a routing table do?
11. What does `0.0.0.0/0` conceptually represent?
12. What does ARP solve on a local IPv4 network?
13. What does NAT do in a typical home network?
14. Why is an open port not automatically a vulnerability?

## DNS

15. What does DNS do?
16. What is recursive DNS?
17. What is caching?
18. Authoritative vs non-authoritative?
19. Why can internet connectivity work while DNS-based applications fail?
20. Why is DNS especially important to Active Directory?
21. What is an SRV record?
22. What does `_ldap._tcp.dc._msdcs.kevinlab.local` help clients locate?

## Transport / packets

23. TCP vs UDP?
24. Why is TCP useful for web traffic?
25. Why is UDP useful for real-time traffic?
26. What is a packet header?
27. What is a payload?
28. What OSI layer is IP associated with?
29. What layer are TCP and UDP associated with?
30. What layer are application protocols such as DNS/HTTP conceptually associated with?

## Wireshark

31. Why use Wireshark?
32. What does `ip.addr == X` accomplish?
33. What is a TLS Client Hello?
34. How could packet evidence complement Windows Event Logs?

## Windows internals

35. What is a process?
36. What is a PID?
37. What is a thread?
38. What is a DLL?
39. What does the Windows kernel do?
40. User mode vs kernel mode?
41. What is `svchost.exe`?
42. Why can multiple `svchost.exe` instances be normal?

## Windows Server

43. Why is "Windows Server = Active Directory" wrong?
44. What is a server role?
45. Name several Windows Server roles.
46. Why might enterprises separate server roles?

## Active Directory

47. What problem does AD solve?
48. What is a domain?
49. What is a Domain Controller?
50. What is an OU?
51. Why is an OU different from a default container?
52. What is an AD forest?
53. What is the schema?
54. What is the Global Catalog?
55. What is a trust?
56. What is a tree?
57. What are users, groups, and computer objects?

## Authentication

58. Authentication vs authorization?
59. Explain Kerberos from login to service access.
60. What is the KDC?
61. What is a TGT?
62. What is a service ticket?
63. Why does Kerberos use tickets?
64. What does `klist` show?
65. What is NTLM?
66. What is password spraying?
67. What is credential stuffing?
68. What is Kerberoasting at a high conceptual level?

## Group Policy

69. Group Policy vs GPO?
70. Where can GPOs be linked?
71. Why was CLIENT01 placed in Workstations?
72. What does `gpupdate /force` do?
73. What does `gpresult /r` prove?
74. Give examples of security controls that can be configured through GPO.

## Access control

75. What is AGDLP?
76. Why use Global Groups?
77. Why use Domain Local groups?
78. Why avoid direct user permissions?
79. Share permissions vs NTFS permissions?
80. Why did Alice get HR but not Finance?

## Domain health

81. What does `Get-ADDomain` show?
82. `Get-ADForest`?
83. `Get-ADDomainController`?
84. What are NTDS, DNS, KDC, and Netlogon?
85. What does `dcdiag /test:Advertising` test?
86. What does `dcdiag /test:DNS` test?
87. What does `nltest /dsgetdc` do?
88. What does `Test-ComputerSecureChannel` test?

## Event logs

89. 4624?
90. 4625?
91. 4688?
92. 4720?
93. 4726?
94. 4728?
95. 4729?
96. 4104?
97. Actor vs target?
98. Why can CLIENT01 and SRV-DC01 contain different evidence?
99. Why is a selected Event ID not enough without machine/log/context?
100. Why might PowerShell filtering beat manual Event Viewer scrolling?

## PowerShell visibility

101. 4688 vs 4104?
102. Why enable process command-line visibility?
103. What sensitive-information concern exists with command-line logging?
104. Why do attackers like PowerShell?
105. Why do defenders want PowerShell logging?

## Hardening

106. What is hardening?
107. Detection vs prevention?
108. What is attack surface?
109. What is a security baseline?
110. What is configuration drift?
111. What is least privilege?
112. What is privilege separation?
113. Why review Domain Admins?
114. What was the initial password minimum?
115. What did you change it to?
116. Why can an overly aggressive lockout threshold be harmful?
117. Domain/Private/Public firewall profiles?
118. Inbound vs outbound?
119. Why not just disable the firewall?
120. Why disable SMBv1?
121. What does SMB signing protect?
122. Why validate functionality after hardening?

## Troubleshooting

123. Why did CLIENT01 initially fail AD DNS discovery?
124. Why did ping success not prove AD was configured correctly?
125. Why did you verify group membership with PowerShell?
126. What is the "configure → verify → test" mindset?
127. Why should you not memorize the DC's old IP?
128. Why does system architecture matter when interpreting logs?

---

# 42. Mastery Checklist

A concept is not mastered because you recognize the word. Mark it complete when you can explain it without notes **and** use it appropriately.

## Cybersecurity

- [ ] CIA Triad
- [ ] confidentiality
- [ ] integrity
- [ ] availability
- [ ] attacker vs defender perspective
- [ ] detection vs prevention
- [ ] attack surface
- [ ] hardening
- [ ] security baseline
- [ ] configuration drift
- [ ] least privilege
- [ ] privilege separation
- [ ] defense in depth

## Networking

- [ ] IPv4
- [ ] IPv6
- [ ] static vs dynamic IP
- [ ] DHCP
- [ ] DHCP reservation
- [ ] default gateway
- [ ] router
- [ ] routing table
- [ ] ARP
- [ ] NAT
- [ ] ports
- [ ] TCP
- [ ] UDP
- [ ] packets
- [ ] payload
- [ ] OSI model
- [ ] DNS
- [ ] recursive DNS
- [ ] caching
- [ ] authoritative DNS
- [ ] HTTP
- [ ] HTTPS/TLS
- [ ] ping
- [ ] traceroute
- [ ] Wireshark

## Windows

- [ ] process
- [ ] PID
- [ ] thread
- [ ] DLL
- [ ] Windows kernel
- [ ] user mode
- [ ] kernel mode
- [ ] svchost.exe
- [ ] Windows services
- [ ] Event Viewer
- [ ] Windows Security log
- [ ] Windows auditing
- [ ] Defender
- [ ] Firewall profiles

## Enterprise / AD

- [ ] Windows Server roles
- [ ] AD DS
- [ ] domain
- [ ] Domain Controller
- [ ] forest
- [ ] tree
- [ ] schema
- [ ] Global Catalog
- [ ] trust
- [ ] OU
- [ ] default container vs OU
- [ ] user object
- [ ] computer object
- [ ] group
- [ ] LDAP
- [ ] DNS/SRV records
- [ ] Kerberos
- [ ] KDC
- [ ] TGT
- [ ] service ticket
- [ ] NTLM
- [ ] authentication
- [ ] authorization
- [ ] Group Policy
- [ ] GPO
- [ ] AGDLP
- [ ] Global group
- [ ] Domain Local group
- [ ] SMB
- [ ] NTFS
- [ ] share vs NTFS permission

## Lab operations

- [ ] configure static DC networking
- [ ] verify DNS
- [ ] promote server to DC conceptually
- [ ] verify DC health
- [ ] create OUs/users/groups
- [ ] verify AD objects with PowerShell
- [ ] nest groups using AGDLP
- [ ] create/publish SMB resources
- [ ] assign permissions
- [ ] build Windows client
- [ ] point domain client at AD DNS
- [ ] join domain
- [ ] verify domain membership
- [ ] verify secure channel
- [ ] inspect Kerberos tickets
- [ ] apply/verify GPO
- [ ] validate allowed and denied access

## Telemetry

- [ ] 4624
- [ ] 4625
- [ ] logon types 2/3/5/7/10/11
- [ ] 4688
- [ ] 4720
- [ ] 4726
- [ ] 4728
- [ ] 4729
- [ ] 4104
- [ ] actor vs target
- [ ] Security log vs audit-policy category
- [ ] 4688 vs 4104
- [ ] `Get-WinEvent`
- [ ] interpret events in host/context

## Hardening

- [ ] review privileged groups
- [ ] explain Domain Admins
- [ ] explain Enterprise Admins
- [ ] explain Schema Admins
- [ ] review domain password policy
- [ ] explain lockout tradeoffs
- [ ] inspect firewall profiles
- [ ] explain inbound/outbound
- [ ] inspect SMB versions
- [ ] explain SMB signing
- [ ] explain SMBv1 risk
- [ ] make a justified remediation
- [ ] verify remediation

---

# Final Mental Model

If you remember only one diagram, remember this:

```text
NETWORK
  ↓
DNS finds the enterprise services
  ↓
DOMAIN CONTROLLER provides identity services
  ↓
KERBEROS proves who the user is
  ↓
ACTIVE DIRECTORY knows users, computers, and groups
  ↓
AUTHORIZATION decides what resources are allowed
  ↓
GROUP POLICY configures users/computers
  ↓
SMB + NTFS expose and protect shared resources
  ↓
WINDOWS AUDITING records important behavior
  ↓
EVENT VIEWER / POWERSHELL lets analysts investigate
  ↓
HARDENING reduces unnecessary opportunity
  ↓
VALIDATION proves the controls still work
```

And from the security perspective:

```text
Build it
  ↓
Understand it
  ↓
Configure it
  ↓
Verify it
  ↓
Generate known activity
  ↓
Observe it
  ↓
Investigate it
  ↓
Harden it
  ↓
Retest it
```

That is the foundation built through the completion of Project 1.

---

# End of Phase-1 / Project-1 Review

**Project completed:** Enterprise Active Directory Security Lab

The project demonstrated the complete relationship between:

```text
Identity
Authentication
Authorization
Enterprise resources
Centralized policy
Security telemetry
Investigation
Hardening
Validation
```

The next stage of study should build on this foundation rather than replace it.
