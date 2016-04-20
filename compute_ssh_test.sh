#!/bin/bash
for i in `cat /root/.ssh/config | grep Host | grep -v HostName | awk '{ print $2 }'`;do echo "Test ssh to $i"; ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 $i "exit"; done;

