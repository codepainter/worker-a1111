#!/bin/sh

sudo apt-add-repository ppa:fish-shell/release-3 

sudo apt-get update && sudo apt-get install -y git wget curl fish

while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do
    echo "Waiting for other apt-get instances to exit"
    # Sleep to avoid pegging a CPU core while polling this lock
    sleep 1
done

