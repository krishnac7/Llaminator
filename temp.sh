# Update and upgrade system packages
echo -e "\n====== Updating and upgrading packages ======\n"
sudo apt update -y
sudo apt upgrade -y

# Install Ollama and its models
echo -e "\n====== Installing required modules ======\n"
curl -fsSL https://ollama.com/install.sh | sh
echo "waiting for ollama to start..."
sleep 10
echo -e "\n====== Fetching llama2 7B ======\n"
ollama pull llama2

# Install python3-pip
echo -e "\n====== Installing python3-pip ======\n"
sudo apt install python3-pip -y

# Install Flask and Ollama Python packages
echo -e "\n====== Installing Flask and Python packages ======\n"
pip install flask ollama

#configure network
echo -e "\n====== configuring firewall ====== \n"
sudo ufw allow 80/tcp
sudo ufw allow ssh
yes | sudo ufw enable
sudo ufw reload

#setup ports
echo -e "\n====== Setting up variables ====== \n"
export PORT=80

#setup startup scripts
echo -e "\n====== Setting up startup scripts ====== \n"
#remove old service
if systemctl --quiet is-active myScreenStartup.service; then
    sudo systemctl stop myScreenStartup.service >/dev/null 2>&1
    sudo systemctl disable myScreenStartup.service >/dev/null 2>&1
    echo "Service stopped and disabled."
else
    echo "Service does not exist or is not running."
fi
if [ -f /etc/systemd/system/myScreenStartup.service ]; then
    sudo rm /etc/systemd/system/myScreenStartup.service >/dev/null 2>&1
    sudo systemctl daemon-reload >/dev/null 2>&1
    sudo systemctl reset-failed >/dev/null 2>&1
    echo "Service file removed and systemd reloaded."
else
    echo "Service file does not exist."
fi


#create new
echo -e "[Unit]\nDescription=Start My Screen Session\nAfter=network.target\n\n[Service]\nType=forking\nEnvironment=\"PORT=80\"\nExecStart=/usr/bin/screen -dmS llaminator python3 /root/Llaminator/main.py\n\n[Install]\nWantedBy=multi-user.target" | sudo tee /etc/systemd/system/myScreenStartup.service > /dev/null
sudo chmod +x /etc/init.d/myScreenStartup.sh
sudo systemctl daemon-reload
sudo systemctl enable myScreenStartup.service
sudo systemctl start myScreenStartup.service
timeout 10 sudo systemctl enable myScreenStartup.service >/dev/null 2>&1


echo -e "\n====== now running ======> \n"
echo -e " _     _                 _             _             \n| |   | |               (_)           | |            \n| |   | | __ _ _ __ ___  _ _ __   __ _| |_ ___  _ __ \n| |   | |/ _\` | '_ \` _ \\| | '_ \\ / _\` | __/ _ \\| '__|\n| |___| | (_| | | | | | | | | | | (_| | || (_) | |   \n\\_____/_|\\__,_|_| |_| |_|_|_| |_|\\__,_|\\__\\___/|_|   \n                                                     \n                                                     "
echo -e "\nYou can access the ui on http://<FloatingIP> \n"

