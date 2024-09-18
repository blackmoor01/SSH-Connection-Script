#!/bin/bash

# Function to display a welcome message
echo "========================================"
echo "WELCOME TO EC2 SSH CONNECTION HELPER"
echo "========================================"

# Prompt the user for the public IP address of the EC2 instance
while true; do
	read -p "Enter the public IP address of the EC2 instance: " ec2_ip
	# Vaidate that the input is not empty and follows a basic IP pattern
	if [[ "$ec2_ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
		break
	else
		echo "Invalid Ip address. Please enter a valid public IP."
	fi
done

#Prompt the user for the path to the SSH key file
while true; do
	read -p "Enter the full path to your SSH key file (e.g., /home/user/keypair.pem): " key_file
	# Validate that the file exists
	if [ -f "$key_file" ]; then
		break
	else
		echo "The specified key file does not exist. Please check the path."
	fi
done

# Prompt the user for the username (default is 'ubuntu')
read -p "Enter the username (default is 'ubuntu'): " username

# Set default username to 'ubuntu' if not provided
if [ -z "$username" ]; then
	username='ubuntu'
fi

# Display the details entered by the user and ask for confirmation
echo "========================================"
echo "  Please confirm the details below:  "
echo "----------------------------------------"
echo "  EC2 Public IP Address: $ec2_ip   "
echo "  SSH Key File: $key_file  "
echo "  Username: $username"
echo "========================================"


read -p "Are the details correct? (Y/N): " confirmation

if [[ $confirmation == "y" || $confirmation == "Y" ]]; then

	# Set the correct permissions for the key file
	chmod 400 "$key_file"

	# Execute the SSH Connection
	echo "Connecting to $username@$ec2_ip..."
	ssh -i "$key_file" "$username@$ec2_ip"
else
	echo "Connection aborted. Please run the script again with correct details."
	exit 1
fi
