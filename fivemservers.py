#!/usr/bin/python

# Get a list of current FiveM-servers

import socket

UDP_IP = "updater.fivereborn.com" # updater.fivereborn.com
UDP_PORT = 30110
MESSAGE = "\xFF\xFF\xFF\xFFgetservers GTA5 4 full empty"
RESPONSE = "getserversResponse"
 
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(("0.0.0.0", 0))

sock.sendto(MESSAGE, (UDP_IP, UDP_PORT))
 
while True:
  data, addr = sock.recvfrom(1536) # buffer size is 1024 bytes
  b = bytearray(data)
  if data.startswith("\xFF\xFF\xFF\xFF%s" % RESPONSE):
    #print "%s:" % RESPONSE
    p=len(RESPONSE) + 3
    while p < len(data):
      # Find token
      while p < len(data) and b[p] != ord('\\'):
        p+=1
      p+=1
      if p+3 < len(data):
        if "%c%c%c" % (b[p], b[p+1], b[p+2]) == "EOT":
          # EndOfTransmission
          exit(0)
      if p+6 < len(data):
        print "%d.%d.%d.%d:%d" % (b[p], b[p+1], b[p+2], b[p+3], b[p+4] * 256 + b[p+5])
  
