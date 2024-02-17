#!/bin/bash
sudo mkdir -p /opt/locations
sudo mv ~/locations-postgres.jar /opt/locations

sudo apt-get update
sudo apt-get install -y openjdk-17-jdk-headless
sudo apt-get install -y postgresql postgresql-contrib
sudo -u postgres psql -c "CREATE DATABASE mydatabase;"
sudo -u postgres psql -c "CREATE USER user1 WITH PASSWORD 'Akshaya11290';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO user1;"
echo 'PG_HOST=localhost' | sudo tee -a /etc/environment
echo 'PG_DB=mydatabase' | sudo tee -a /etc/environment
echo 'PG_USER=user1' | sudo tee -a /etc/environment
echo 'PG_PASSWORD=Akshaya11290' | sudo tee -a /etc/environment
echo '_JAVA_OPTIONS=-Dspring.profiles.active=postgres' | sudo tee -a /etc/environment
. /etc/environment

# Add the service
echo "[Unit]
Description=My Java Application

[Service]
User=root
ExecStart=/usr/bin/java -jar /opt/locations/locations-postgres.jar
SuccessExitStatus=143
TimeoutStopSec=10
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/locations.service

# Reload the systemd manager configuration
sudo systemctl daemon-reload

# Enable your service to start on boot
sudo systemctl enable locations

# Start your service
# sudo systemctl start locations

# /usr/sbin/waagent -force -deprovision+user && HISTSIZE=0 && sync