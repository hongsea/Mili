#!/bin/bash

./init_config.sh
./install-deps.sh

user=$(id -un)
script_location="/Users/$user/.mili/bin"
service_location="/Users/$user/Library/LaunchAgents"

echo "Install Mili scripts..."
mkdir -p $script_location
cp ./mili.sh "$script_location/mili.sh"
sed -i '' "s/<-USER->/$user/g" "$script_location/mili.sh"
chmod +x "$script_location/mili.sh"

echo "Add MikroTik service..."
cp ../services/com.mikrotik.plist "$service_location/com.mikrotik.plist"
sed -i '' "s/<-USER->/$user/g" "$service_location/com.mikrotik.plist"

echo "Enable MikroTik service..."
launchctl remove com.mikrotik
launchctl load -w "/Users/$user/Library/LaunchAgents/com.mikrotik.plist"
launchctl start com.mikrotik