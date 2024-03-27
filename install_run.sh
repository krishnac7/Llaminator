# Update and upgrade system packages
echo "====== Updating and upgrading packages ======"
sudo apt update -y
sudo apt upgrade -y

# Install Ollama and its models
echo "====== Installing Ollama ======"
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama2

# Install python3-pip
echo "====== Installing python3-pip ======"
sudo apt install python3-pip -y

# Install Flask and Ollama Python packages
echo "====== Installing Flask and Ollama Python packages ======"
pip install flask ollama

screen -S llaminator -m -d  python3 main.py
echo "====== now running ======> "
echo " _     _                 _             _             
| |   | |               (_)           | |            
| |   | | __ _ _ __ ___  _ _ __   __ _| |_ ___  _ __ 
| |   | |/ _` | '_ ` _ \| | '_ \ / _` | __/ _ \| '__|
| |___| | (_| | | | | | | | | | | (_| | || (_) | |   
\_____/_|\__,_|_| |_| |_|_|_| |_|\__,_|\__\___/|_| "
