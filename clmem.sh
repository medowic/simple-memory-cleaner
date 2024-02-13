#!/bin/bash

# This is memory cleaner script.
# It already include in simple-memory-cleaner/install.sh

while true; do
    sync; echo 1 > /proc/sys/vm/drop_caches
    sleep 30m
done