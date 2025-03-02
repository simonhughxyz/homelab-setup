#!/bin/bash
#
# Author: Simon H Moore <simon@simonhugh.xyz>
# License: MIT (see LICENSE file)
#
# This script generates a secure TSIG key for Dynamic DNS (DDNS) and saves it to predefined locations.
#
# The generated key is stored in multiple locations to ensure availability for DHCP and BIND.
#
# The key file is secured with proper permissions to prevent unauthorized access.

# Define the output locations where the keys are saved to
KEY_FILES=(
    "/home/simon/dump/ddns.key"
    "/home/simon/dump/ddns2.key"
)

KEY_NAME="ddns-key"

# Generate a secure 256-bit (32-byte) base64-encoded key
SECRET_KEY=$(openssl rand -base64 32)

# Write the key file to multiple locations
for KEY_FILE in "${KEY_FILES[@]}"; do

    cat > "$KEY_FILE" <<EOF
key "$KEY_NAME" {
    algorithm hmac-sha256;
    secret "$SECRET_KEY";
};
EOF

    # Set permissions for security
    chmod 600 "$KEY_FILE"
    echo "DDNS key has been generated and saved to $KEY_FILE"
done

# Output success message
echo "Ensure that your dhcpd.conf and named.conf reference the key name \"$KEY_NAME\"."
