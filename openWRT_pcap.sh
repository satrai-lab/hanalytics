 #!/bin/bash
      
      MAC_ADDRESS=$1
      DURATION=$2
      CAPTURE_DIR="/root/captures/IBPS"
      OUTPUT_FILE="$CAPTURE_DIR/$MAC_ADDRESS.pcap"
      
      mkdir -p $CAPTURE_DIR
      cd $CAPTURE_DIR
      timeout $DURATION tcpdump ether host $MAC_ADDRESS -w $OUTPUT_FILE
      echo "Running script with MAC Address: $MAC_ADDRESS for $DURATION seconds"