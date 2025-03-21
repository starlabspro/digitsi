#!/bin/bash

echo "🔄 Applying Custom Web Customizations..."

echo "📝 Starting background check..."
echo "Checking directory: /custom/backgrounds"
ls -la /custom/backgrounds || echo "❌ Cannot access backgrounds directory"

# Copy backgrounds if they exist
if [ -d "/custom/backgrounds" ]; then
    echo "✅ Background directory found"
    echo "🎨 Updating virtual backgrounds..."
    
    echo "Creating destination directory..."
    mkdir -p "/usr/share/jitsi-meet/images/virtual-background"
    
    echo "Copying background files..."
    cp -rv "/custom/backgrounds"/* "/usr/share/jitsi-meet/images/virtual-background/" || echo "❌ Copy failed"
    
    echo "Setting permissions..."
    chmod -R 755 "/usr/share/jitsi-meet/images/virtual-background"
    
    echo "Setting ownership..."
    chown -R www-data:www-data "/usr/share/jitsi-meet/images/virtual-background"
    
    echo "Verifying copied files..."
    ls -la "/usr/share/jitsi-meet/images/virtual-background"
else
    echo "❌ Background directory not found at /custom/backgrounds"
    echo "Current directory structure:"
    ls -la /custom/
fi

# Backup original watermark if not already backed up
if [ ! -f /usr/share/jitsi-meet/images/watermark-bak.png ]; then
    cp /usr/share/jitsi-meet/images/watermark.png /usr/share/jitsi-meet/images/watermark-bak.png
fi

# Replace Jitsi logo with our custom one
cp /custom/custom-logo.svg /usr/share/jitsi-meet/images/watermark.svg

# Update UI background references
if [ -f "/usr/share/jitsi-meet/libs/app.bundle.min.js" ]; then
    echo "🖌️ Updating Jitsi UI for custom backgrounds..."
    for i in {1..7}; do
        sed -i "s|background-$i.jpg|school-$i.jpg|g" "/usr/share/jitsi-meet/libs/app.bundle.min.js"
    done
fi

# Configure guest access
if [ -f "/custom/config.js" ]; then
    echo "🔧 Configuring guest access..."
    sed -i "s|// anonymousdomain: 'guest.\$DOMAIN',|anonymousdomain: 'guest.\$DOMAIN',|" "/custom/config.js"
fi

# Configure Nginx
if ! grep -q "location /images/" "/etc/nginx/sites-available/meet.conf"; then
    echo "🌐 Configuring Nginx..."
    echo -e "\nlocation /images/ {\n    root /usr/share/jitsi-meet;\n    autoindex on;\n}" >> "/etc/nginx/sites-available/meet.conf"
    systemctl restart nginx
fi

docker-compose restart web
echo "✅ Customizations applied successfully!"
