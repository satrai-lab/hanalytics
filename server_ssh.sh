!/bin/bash
      
      # Check if MAC_ADDRESS is provided
      if [ -z "$1" ]; then
        echo "Usage: $0 <MAC_ADDRESS>"
        exit 1
      fi
      
      MAC_ADDRESS="$1"
      CAPTURE_DIR="/srv/nfs_share1/IBPS"
      PCAP_FILE="$CAPTURE_DIR/$MAC_ADDRESS.pcap"
      ANALYSIS_FILE="$CAPTURE_DIR/$MAC_ADDRESS.txt"
      # HA_URL="<YOUR_HA_URL>/api/states/sensor.packet_capture_analysis"
      HA_URL="<YOUR_HA_URL>/api/states/sensor.packet_capture_analysis"
      
      # Token should ideally be stored in a secure manner
      # like this: HA_TOKEN=$(cat /path/to/token_file)
      HA_TOKEN="<YOUR_HA_TOKEN>"
      # Validate MAC_ADDRESS
      
      cd "$CAPTURE_DIR" || { echo "Failed to change directory to $CAPTURE_DIR"; exit 1; }
      
      # Check if PCAP_FILE exists
      if [ ! -f "$PCAP_FILE" ]; then
        echo "PCAP file $PCAP_FILE not found."
        exit 1
      fi
      
      # Run capinfos and capture its output
      if ! capinfos "$PCAP_FILE" > "$ANALYSIS_FILE"; then
        echo "capinfos command failed."
        exit 1
      fi
      
      python3 parser_JSON.py $ANALYSIS_FILE
      #ANALYSIS_OUTPUT=$(cat "$ANALYSIS_FILE")
      
      # Send the analysis to Home Assistant
      response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Bearer $HA_TOKEN" \
           -H "Content-Type: application/json" \
           -d '{"state": "'"$ANALYSIS_OUTPUT"'", "attributes": {"friendly_name": "Packet Capture Analysis"}}' \
           "$HA_URL" -k)
      
      response=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Authorization: Bearer $HA_TOKEN" \
           -H "Content-Type: application/json" \
           -d '{"state": "Hello", "attributes": {"friendly_name": "Packet Capture Analysis"}}' \
           "$HA_URL" -k)
      
      if [ "$response" -ne 200 ]; then
        echo "Failed to send data to Home Assistant. HTTP response code: $response"
        exit 1
      fi
      
      echo "Analysis successfully sent to Home Assistant."