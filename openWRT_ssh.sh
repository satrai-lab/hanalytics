!/bin/bash
      #
      ssh -i /config/.ssh/id_rsa_OpenWRT_v2 -o 'StrictHostKeyChecking=no' root@[openwrt_adress]  "sh -s" < /config/openWRT_pcap.sh "'$1'" "'$2'"