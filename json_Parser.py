 import requests
      import re
      
      # File path to the text file
      file_path = './00:00:00:00:00:29.txt'
      # Home Assistant API details
      headers = {
          'Authorization': <INSERT HA ACCESS TOKEN>,
          'Content-Type': 'application/json',
      }
      base_url = '<YOUR_HA_URL>/api/states/'
      
      # Function to update a sensor in Home Assistant
      def update_sensor(sensor, state, attributes):
          json_data = {
              'state': state,
              'attributes': attributes,
          }
          response = requests.post(
              f'{base_url}{sensor}',
              headers=headers,
              json=json_data,
              verify=False,
          )
          return response
      # Dictionary to map the sensor names to their keys in the file
      sensor_map = {
          'sensor.number_of_packets': 'Number of packets',
          'sensor.file_size': 'File size',
          'sensor.data_size': 'Data size',
          'sensor.capture_duration': 'Capture duration',
          'sensor.first_packet_time': 'First packet time',
          'sensor.last_packet_time': 'Last packet time',
          'sensor.data_byte_rate': 'Data byte rate',
          'sensor.data_bit_rate': 'Data bit rate',
          'sensor.average_packet_size': 'Average packet size',
          'sensor.average_packet_rate': 'Average packet rate',
          'sensor.sha256': 'SHA256',
          'sensor.ripemd160': 'RIPEMD160',
          'sensor.sha1': 'SHA1',
          'sensor.strict_time_order': 'Strict time order',
          'sensor.number_of_interfaces_in_file': 'Number of interfaces in file',
          'sensor.interface_0_encapsulation': 'Encapsulation',
          'sensor.interface_0_capture_length': 'Capture length',
          'sensor.interface_0_time_precision': 'Time precision',
          'sensor.interface_0_time_ticks_per_second': 'Time ticks per second', 
          'sensor.interface_0_number_of_stat_entries': 'Number of stat entries',
          'sensor.interface_0_number_of_packets': 'Number of packets',
      }
      # Read the file and extract sensor values
      with open(file_path, 'r') as file:
          data = file.read()
      # Extract sensor values using regex
      sensor_data = {}
      for sensor, key in sensor_map.items():
          match = re.search(f'{key}:\\s*(.*)', data)
          if match:
              value = match.group(1).strip()
              sensor_data[sensor] = value
      # Update sensors in Home Assistant
      for sensor, value in sensor_data.items():
          state = value
          attributes = {'friendly_name': sensor_map[sensor]}
          response = update_sensor(sensor, state, attributes)
          print(f'Updated {sensor} with state {state}: {response.status_code}')