#!/bin/bash

# Function to display messages in a consistent format
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

log "Starting LAMP stack deployment script..."

# Update package list and upgrade installed packages
log "Updating package list and upgrading installed packages..."
sudo apt update
sudo apt upgrade -y

# Install LAMP stack components
log "Installing Apache, MySQL, PHP, and other necessary packages..."
sudo apt install apache2 mysql-server php libapache2-mod-php php-mysql -y

# Clone PHP application from GitHub
log "Cloning PHP application from GitHub..."
git clone https://github.com/laravel/laravel.git /var/www/html/  

# Configure Apache virtual host
log "Configuring Apache virtual host..."
cat <<EOL | sudo tee /etc/apache2/sites-available/your_php_app.conf
<VirtualHost *:80>
    ServerAdmin osasu205@gmail.com
    DocumentRoot /var/www/html
    ServerName exam_project.com
    ServerAlias www.exam_project.com
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Enable the Apache virtual host
log "Enabling the Apache virtual host..."
sudo a2ensite your_php_app.conf

# Restart Apache
log "Restarting Apache server..."
sudo systemctl restart apache2

# Secure MySQL installation
log "Securing MySQL installation..."
sudo mysql_secure_installation

log "LAMP stack deployment completed successfully!"
