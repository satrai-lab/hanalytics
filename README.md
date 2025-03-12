# HAnalytics

## Overview
HAnalytics is an advanced plugin developed specifically for Home Assistant, the leading open-source platform for smart home management. It expands Home Assistant's core functionality by integrating robust benchmarking and performance analytics. The primary purpose is to allow homeowners, developers, and system integrators to assess IoT device performance comprehensively, guiding data-driven decisions for selecting the most effective smart home equipment.

HAnalytics provides actionable metrics on device responsiveness, reliability, energy efficiency, and network stability.

## Key Features

### 📈 Device Benchmarking
- **Performance Evaluation**: Measure real-world responsiveness, reliability, and overall performance of IoT devices.
- **Reliability Testing**: Conduct consistent tests under various scenarios to assess stability and predictability.

### 📊 Data-Driven Insights
- **Latency Metrics**: Accurately measure communication delays to evaluate device responsiveness.
- **Energy Consumption Tracking**: Monitor power usage to identify energy-efficient devices.
- **Network Efficiency Analysis**: Evaluate the impact of devices on network traffic and connectivity quality.

### 🔗 Seamless Integration
- **Unified Interface**: Operates seamlessly within Home Assistant’s existing dashboards and automation controls.
- **Plug-and-Play**: Requires minimal setup for immediate integration and use.

### 🔒 Privacy-Focused
- **Local Data Processing**: All analytics and data collection occur locally, preserving user privacy and security.
- **No External Cloud Dependencies**: Ensures sensitive smart home data remains confidential within your own network.

## Video Demos & Examples

Explore a practical demonstration showcasing an earlier version of **HAnalytics**, previously named **IBPS**:

📺 [**Watch Video Demo**](https://drive.google.com/file/d/1kHZ49kxT0WVicjKEPoCurpzSf9F5AfLA/view?usp=sharing)

This video provides a visual walkthrough, highlighting key functionalities, UI interactions, and core analytics features.


## System Architecture Overview

Below is the recommended/tested lab architecture for implementing **HAnalytics** benchmarking tests effectively:   

![Satrai Living Lab Architecture](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image.png) 

*Figure 0: Satrai Living Lab Architecture*

> 💡 Z-Wave Devices implemented, not tested on Satrai Living Lab.

## 📋 Requirements

To properly deploy and run **HAnalytics**, ensure your setup meets the following hardware and software prerequisites as also seen in the architecture (see Lab Deployment).

### Hardware Requirements

Ensure your setup includes:

- **Local PC/Server**:
  - OS: Ubuntu 22.04 LTS or newer
  - Purpose: Used for hosting scripts, packet captures, and data analytics processing

- **Orbi Router** *(or similar generic router)*:
  - Example used: [NETGEAR® Orbi™ RBR350 WiFi 6 Dual-band Mesh Router](https://www.netgear.com/ae/home/wifi/mesh/rbr350/)
  - Purpose: Provides general internet connectivity and network management

- **OpenWRT Router** *(essential for experimental operations)*:
  - OS: [OpenWRT Project](https://openwrt.org/)
  - Requirements: SSH enabled, supports packet capturing tools (e.g., tcpdump)
  - Purpose: Executes network analysis, packet capturing, and simulated attacks for benchmarking
  - Connected Devices:
    - Smart IoT Devices (via WiFi)
    - Raspberry Pi running Home Assistant OS
    - Philips Hue Bridge or any other bridge for connecting devices

- **Home Assistant OS Device (HAOS)**:
  - Hardware: Raspberry Pi 4
  - OS: [Home Assistant OS](https://www.home-assistant.io/installation/raspberrypi)
  - Storage: microSD Card (32GB minimum, Class 10 recommended)
  - Purpose: Core of the HAnalytics deployment, running Home Assistant and managing IoT devices

- **Attacker Pi**:
  - Device: Raspberry Pi 4
  - Purpose: Conducts simulated network attacks to benchmark device resiliency under stress conditions

- **Utility Pi**:
  - Device: Raspberry Pi (any model)
  - Purpose: Benchmarking of smart home speakers or voice-controlled devices without relying on specific APIs
  - Functionality Illustrated in the diagram below:

![*Figure 1: Flowgraph of Utility Pi*](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%201.png)

*Figure 1: Flowgraph of Utility Pi*

## Installation

**HAnalytics** leverages Home Assistant for deployment. Follow the detailed instructions below to properly install and configure your system according to the Satrai Living Lab architecture (as shown in Figure 0).

### Prerequisites

Ensure you have the following components ready before proceeding:

- Raspberry Pi (Recommended: Raspberry Pi 4)
- microSD Card (At least 32GB, Class 10 recommended)
- Home Assistant OS Image
- Balena Etcher or Raspberry Pi Imager (for flashing the OS)
- Stable power supply & network connection

---

### Installation Steps

Follow these steps carefully for a successful installation.

#### Step 1: Download Home Assistant OS

1. Visit the [Home Assistant OS Download Page](https://www.home-assistant.io/installation/raspberrypi).
2. Select your Raspberry Pi model and download the latest `.img.xz` file.

#### Step 2: Flashing the OS to microSD Card

Use either **Balena Etcher** or **Raspberry Pi Imager**:

1. Insert the microSD card into your computer.
2. Launch **Balena Etcher**.
3. Choose the downloaded `.img.xz` file.
4. Select the microSD card as the destination.
5. Click **Flash** and wait for completion.

#### Step 3: Booting Home Assistant OS

1. Safely eject the microSD card from your computer.
2. Insert the microSD card into your Raspberry Pi.
3. Connect your Raspberry Pi to a power supply and network.
4. Allow the Raspberry Pi to boot (approximately 10-15 minutes).

#### Step 3: Accessing Home Assistant

Once booted:

1. From your computer, open a browser.
2. Navigate to:  [`http://homeassistant.local:8123`](http://homeassistant.local:8123/)
3. - If unsuccessful, find your Raspberry Pi IP address (e.g., via router settings) and access: [`http://<RPI_IP_ADDRESS>:8123`](http://<RPI_IP_ADDRESS>:8123)

#### Step 4: Initial Home Assistant Setup

1. Follow on-screen instructions to:
- Create a user account.
- Set your location, timezone, and units.
- Optionally add detected IoT devices.

#### Step 5 (Optional): Enable Advanced Features (SSH & Samba)

1. Navigate to **Settings → Add-ons**.
2. Install and configure:
- **Terminal & SSH** for secure remote access.
- **Samba** for file management.

---

### Deploying HAnalytics (Backup Restore Method)

#### Step 1: Obtain HAnalytics Backup Image

- Access the prepared backup image from the following link:
[HAnalytics Backup Image (Google Drive)](https://drive.google.com/drive/folders/1H0lJDAoUBGu3_f2oSRdEfc_EBBaspHtf)

#### Step 2: Restoring from Backup in Home Assistant

1. Open your Home Assistant interface. You should see the welcome screen:

![Figure 2: Home Assistant Welcome Page](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/bimage%202.png)

Select **RESTORE FROM BACKUP**.

2. Drag and drop the downloaded `.tar` backup file into the designated area:

![Figure 3: Restore from Backup (Part 1)](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/bimage%203.png)

3. Enter the provided encryption key (available on Google Drive):

![Figure 4: Restore from Backup (Part 2)](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/bimage%204.png)

4. Wait for the restoration process to complete. This might take several minutes:

![Figure 5: Restore from Backup Completion](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/bimage%205.png)

---

Once you've completed these steps, your **HAnalytics** plugin is installed and ready for use within your Home Assistant environment.

# HAnalytics Network Analysis Feature

## Network Analysis Overview

The HAnalytics Network Analysis feature captures and analyzes network traffic to benchmark IoT device performance. This guide provides step-by-step instructions for environment preparation, configuration, execution, and analysis.

![Network Analysis Flowgraph](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2014.png)

*Figure 17: Flowgraph of Network Analysis feature of HAnalytics*

The workflow involves:
1. Home Assistant initiates SSH connection to OpenWRT, sending MAC address and runtime parameters.
2. OpenWRT router starts packet capturing.
3. Packet capture files (`.pcap`) are stored temporarily on the router.
4. Files are transferred securely to the analysis server via NFS.
5. Server analyzes packets using `capinfos` and generates structured output.
6. Analysis results are returned to Home Assistant and visualized in the UI.

---

## Step-by-Step Network Analysis Setup

### 1. Environment Preparation

**OpenWRT Router Configuration:**
- Enable SSH access.
- Install packet capturing tools:
```bash
opkg update
opkg install tcpdump timeout
```

**Server Configuration (Ubuntu ≥22.04):**
- Install required tools:
```bash
sudo apt update
sudo apt install tcpdump wireshark python3 python3-pip nfs-kernel-server
```
- Configure NFS for file sharing:
```bash
sudo mkdir -p /srv/nfs_share1/IBPS
sudo chmod -R 755 /srv/nfs_share1/IBPS
sudo echo '/srv/nfs_share1/IBPS *(rw,sync,no_root_squash)' >> /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```

**Generate SSH Keys:**
```bash
ssh-keygen -t rsa -b 2048
ssh-copy-id root@<OpenWRT_IP>
```

---

### 2. Script Configuration

**Place scripts on the server:**
- `/config/openWRT_ssh.sh`
- `/config/openWRT_pcap.sh`
- `/scripts/server_ssh.sh`
- `/scripts/server_pcap.sh`

**Set script permissions:**
```bash
chmod +x /config/openWRT_ssh.sh /config/openWRT_pcap.sh /scripts/server_ssh.sh /scripts/server_pcap.sh
```

**Secure Home Assistant Token:**
Store token securely and dynamically load it:
```bash
HA_TOKEN=$(cat /config/ha_token.txt)
```

**Verify file paths and URLs:**
- Confirm paths (`/config/.ssh/id_rsa_OpenWRT_v2`, `/srv/nfs_share1/IBPS`).
- Update Home Assistant URLs in scripts.

---

### 3. Packet Capturing

**Initiate Capture from the Server:**
```bash
/config/openWRT_ssh.sh <MAC_ADDRESS> <DURATION>
```
- Replace `<MAC_ADDRESS>` with the device MAC.
- Replace `<DURATION>` with capture duration in seconds.

Captured files saved on router at `/root/captures/IBPS` and transferred to server via NFS.

---

### 4. Packet Capture Analysis

Run the server-side analysis script:
```bash
/scripts/server_ssh.sh <MAC_ADDRESS>
```
- Analyzes `.pcap` file and outputs structured data.
- Converts data to JSON format using `parser_JSON.py`.

---

### 5. Sending Analysis Results to Home Assistant

Execute script to send data to Home Assistant:
```bash
/scripts/server_pcap.sh <MAC_ADDRESS>
```
- Ensure Home Assistant sensors (`sensor.packet_capture_analysis`) are active.

---

### Included Scripts

- **openWRT_ssh.sh:** Initiates packet capture remotely on OpenWRT.
- **openWRT_pcap.sh:** Executes `tcpdump` to capture packets on OpenWRT.
- **server_ssh.sh:** Analyzes captured packets using `capinfos`.
- **server_pcap.sh:** Uploads analysis results to Home Assistant.
- **parser_JSON.py:** Parses captured data into JSON for Home Assistant integration.

Ensure scripts and environment configurations align precisely with your setup for the network analysis to work (addresses of the components and file paths e.g YOUR_HA_URL). If the scripts are not properly placed, the buttons of the Hanalytics UI described in the following section might not function properly.
 


## Showcasing the HAnalytics UI

HAnalytics provides a user-friendly and intuitive UI, consisting of three primary dashboards for seamless device benchmarking and performance analysis.

### Dashboard 1: Main Benchmarking Dashboard

This primary dashboard enables the evaluation and analysis of your connected smart devices, offering comprehensive visualization tools and interactive control panels.

#### Features:

- **Map View**
  - Displays your smart home’s layout and indicates the state (**On/Off**) and power consumption metrics for each IoT device.

- **Benchmarking Test Panel**
  - Select devices individually for detailed benchmarking.
  - View device information and execute tests such as Ping Tests to analyze latency and network performance.
  - Monitor the real-time state of the device (Active or Idle).
  - Set the benchmarking test duration using a convenient slider.
  - Initiate tests quickly with the integrated **Run** button.

- **Evaluation Criteria** include:
  - Network latency and packet loss.
  - Power consumption statistics.
  - Device operational states and responsiveness.

#### Dashboard Screenshots:

![Dashboard Overview](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%202.png)

*Figure 6: HAnalytics Deployment Dashboard*

---

### Network Performance Analysis Interface

The platform includes dedicated controls for initiating network analysis, offering users actionable insights:

- **Initiate Network Analysis**: Start network capture directly via the UI.
- **Network Metrics Card**: Clearly displays network analysis results, including:
  - Packet capture duration
  - Number of packets captured
  - Data size and capture timestamps
  - Data bit rates (kbps/Mbps)
  - Cryptographic hashes for integrity verification (RIPEMD160, SHA256, etc.)

![Figure 7: Initiate Network Analysis](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%204.png)  
*Figure 7: Button for initiating Network Analysis.*

![Figure 8: Network Analysis Results Card](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%205.png)  
*Figure 8: Detailed network analysis results displayed in the UI.*

---

### Dashboard 2: Historical Power Consumption Data

This dashboard offers interactive visualization to compare power consumption across smart devices:

- **Interactive Diagrams**: Visualize historical data on voltage, current, and total power consumption.
- **System Monitoring**: View historical network throughput and system performance.
- **Device Status Tracking**: Monitor device operational status over extended periods.

![Figure 9: Power Consumption Dashboard](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2010.png)  
*Figure 9: Dashboard displaying interactive diagrams for power consumption tests.*

![Figure 10: Interactive Diagram](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2011.png)  
*Figure 10: Interactive power consumption diagram.*

---

### Dashboard 2: Attack Simulation Dashboard

Designed specifically to assess system resilience, this dashboard facilitates simulated network attacks on IoT devices.

- **Simulated Attack Controls**: Initiate controlled network attacks (ICMP Flood, SYN Flood, UDP Flood).
- **Configurable Attack Parameters**: Specify target IP addresses and define attack duration.
- **Resilience Assessment**: Evaluate device and network stability under controlled attack conditions.

![Figure 11: Attack Dashboard](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2012.png)  
*Figure 11: Dashboard for Benchmarking under Attack Conditions.*

![Figure 12: Attack Parameters Card](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2013.png)  
*Figure 12: UI for configuring attack parameters.*

---

### Dashboard 2: Device Specifications

Quickly access detailed device specifications and technical parameters directly from the UI.

- **Technical Information**: View device dimensions, lifespan, energy usage, and communication protocols (Bluetooth, Zigbee).
- **Interactive Access**: Easily accessible button and detailed information cards.

![Figure 13: Device Specifications Button](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%206.png)  
*Figure 13: Button to access IoT device specifications.*

![Figure 14: Device Specifications Card](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%207.png)  
*Figure 14: Comprehensive IoT device specifications.*

---

### Dashboard 3: IoT Device Custom Attributes

Define and manage custom attributes to extend device monitoring and analytics:

- Easily input custom attributes to enhance device benchmarking.
- Maintain flexibility to accommodate various IoT devices.

![Figure 15: Custom Attributes UI](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%208.png)  
*Figure 15: IoT device custom attributes card.*

![Figure 16: Attribute Entry Form](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%209.png)  
*Figure 16: Interface for adding custom attributes.*

---

    
## Troubleshooting and Maintenance

Follow these guidelines to effectively troubleshoot issues or perform maintenance tasks within the HAnalytics deployment.

### 📌 Creating a Backup of Home Assistant

Regular backups prevent data loss and facilitate quick recovery.

**Backup Steps:**

1. Navigate to your Home Assistant UI.
2. Go to **Settings → System → Backups**.
3. Click on the **Backup Now** button located in the lower-right corner.

   ![Figure 18: Home Assistant Backup Page](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2015.png)  
   *Figure 18: Home Assistant Backup Interface.*

- **Tip:** Name your backups with a clear timestamp format (e.g., `YYYYMMDD`) for easy identification later.
- Store backups securely off-device to ensure recoverability in case of hardware failure.

---

### 📌 Automated Update Procedure

Figure 19 outlines an automated update workflow that includes periodic system updates, automatic backups before updates, and clear error handling procedures.

![Automated HAOS Update Workflow](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2016.png)  
*Figure 19: Automated Update Process for Home Assistant OS.*

- Scheduled checks for available updates.
- Automatic backup creation before updates.
- Error handling for seamless rollback if an update fails.

---

### 📌 Editing and Validating `configuration.yaml`

The `configuration.yaml` file controls vital configurations such as devices, automations, and integrations.

- **Editing `configuration.yaml`:**
  1. Use Home Assistant's built-in Studio Code Server add-on or SSH for file editing.
  2. Navigate to the `/config` directory to locate `configuration.yaml`.

  ![Figure 20: Configuration Directory](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2017.png)  
  *Figure 20: Directory containing `configuration.yaml`.*

- Carefully edit configurations to avoid syntax errors.

- After modifications, validate changes before applying:

  1. Navigate to **Developer Tools → YAML Configuration**.
  2. Click **Check Configuration** to verify syntax correctness.

  ![Figure 21: Developer Tools Interface](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2018.png)  
  *Figure 21: Home Assistant Developer Tools.*

- Once the check passes, safely restart or reload Home Assistant configurations.

---

### 📌 Inspecting Logs for Errors

Logs provide vital information for diagnosing issues.

**Viewing Logs:**

1. Access **Studio Code Server** via the Add-ons page.
2. Navigate to the log files located at the bottom pane.

  ![Figure 22: HAOS Logs](Hanalytics%20Documentation%2018bb360209608055a87fc780cb789056/image%2019.png)  
  *Figure 22: Log Files location in Studio Code Server.*

- Primary log file:
  `homeassistant.log`
- Contains detailed error and debug messages.
- Regularly review this file after making configuration changes or if experiencing unexpected behavior.

- **Common Errors:**
- Syntax errors in YAML configuration.
- Network connectivity issues with devices.
- Permission problems accessing script or external resources.

---

Following these procedures will ensure the robust operation and easy maintenance of your **HAnalytics** system.

## 📞 Contact Us
If you have any questions, feedback, or require support, feel free to reach out.

> ⚠ **Note:** We understand that the current version of this documentation might be confusing in some areas. If anything is unclear or if you need additional guidance, please don't hesitate to contact us.

### 📧 Email Support
For general inquiries and technical support, contact us at:  
**[nikolaos.papadakis@telecom-sudparis.eu](mailto:nikolaos.papadakis@telecom-sudparis.eu)**
