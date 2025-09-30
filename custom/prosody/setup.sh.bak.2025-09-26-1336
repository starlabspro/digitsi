#!/bin/bash

echo "🔄 Applying Prosody Customizations..."

# Get domain dynamically from an environment variable or argument
DOMAIN=${1:-$JITSI_DOMAIN}

if [ -z "$DOMAIN" ]; then
    echo "❌ Error: No domain provided. Please pass it as an argument or set JITSI_DOMAIN."
    exit 1
fi

echo "🌍 Configuring Jitsi for domain: $DOMAIN"

# Define the Prosody config file path
PROSODY_CONFIG="/custom/prosody/conf.avail/$DOMAIN.cfg.lua"

# Enable authentication for meeting creation
if grep -q 'authentication = "anonymous"' "$PROSODY_CONFIG"; then
    echo "🛠️ Enabling authentication for meeting creation..."
    sed -i 's/authentication = "anonymous"/authentication = "internal_plain"/' "$PROSODY_CONFIG"
fi

# Register an admin user for creating meetings
echo "🔐 Setting up admin authentication..."
prosodyctl register admin "$DOMAIN" SecurePassword

# Allow guests to join without authentication
echo "👥 Enabling guest access..."
if ! grep -q "VirtualHost \"guest.$DOMAIN\"" "$PROSODY_CONFIG"; then
    cat <<EOL >> "$PROSODY_CONFIG"

VirtualHost "guest.$DOMAIN"
    authentication = "anonymous"
    c2s_require_encryption = false
EOL
fi

# Restart Prosody inside the container
echo "🔄 Restarting Prosody..."
systemctl restart prosody

echo "✅ Prosody customizations applied successfully for $DOMAIN!"
