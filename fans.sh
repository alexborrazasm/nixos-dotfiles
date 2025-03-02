#!bash

# ASUS Fan Curve Configuration Script
# This script configures fan curves for CPU and GPU across different performance profiles

# Set fan curves for QUIET profile
echo "Setting fan curves for QUIET profile..."
asusctl fan-curve -m quiet -D 0c:16%,20c:16%,40c:16%,60c:20%,70c:40%,80c:80%,90c:100%,100c:100% -e true -f cpu
asusctl fan-curve -m quiet -D 0c:16%,20c:16%,40c:16%,60c:20%,70c:40%,80c:80%,90c:100%,100c:100% -e true -f gpu

# Set fan curves for BALANCED profile
echo "Setting fan curves for BALANCED profile..."
asusctl fan-curve -m balanced -D 0c:20%,20c:20%,40c:20%,60c:50%,70c:65%,80c:80%,90c:100%,100c:100% -e true -f cpu
asusctl fan-curve -m balanced -D 0c:20%,20c:20%,40c:20%,60c:50%,70c:65%,80c:80%,90c:100%,100c:100% -e true -f gpu

# Set fan curves for PERFORMANCE profile
echo "Setting fan curves for PERFORMANCE profile..."
asusctl fan-curve -m performance -D 0c:25%,20c:25%,40c:40%,60c:60%,70c:70%,80c:85%,90c:100%,100c:100% -e true -f cpu
asusctl fan-curve -m performance -D 0c:25%,20c:25%,40c:40%,60c:60%,70c:70%,80c:85%,90c:100%,100c:100% -e true -f gpu

echo "✅ Fan curves have been successfully configured for all profiles!"
