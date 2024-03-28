# Update and upgrade system packages
echo -e "\n====== Updating and upgrading packages ======\n"
sudo apt update -y
sudo apt upgrade -y

# Install Ollama and its models
echo -e "\n====== Installing Ollama ======\n"
curl -fsSL https://ollama.com/install.sh | sh
echo "waiting for ollama to start..."
sleep 10
echo -e "\n====== Fetching llama2 7B ======\n"
ollama pull llama2

# Install python3-pip
echo -e "\n====== Installing python3-pip ======\n"
sudo apt install python3-pip -y

# Install Flask and Ollama Python packages
echo -e "\n====== Installing Flask and Ollama Python packages ======\n"
pip install flask ollama

screen -S llaminator -m -d  python3 main.py
echo -e "\n====== now running ======> \n"
echo -e " _     _                 _             _             \n| |   | |               (_)           | |            \n| |   | | __ _ _ __ ___  _ _ __   __ _| |_ ___  _ __ \n| |   | |/ _\` | '_ \` _ \\| | '_ \\ / _\` | __/ _ \\| '__|\n| |___| | (_| | | | | | | | | | | (_| | || (_) | |   \n\\_____/_|\\__,_|_| |_| |_|_|_| |_|\\__,_|\\__\\___/|_|   \n                                                     \n                                                     "
echo -e "\nYou can access the ui on http://<PublicIP>:8080 \n"
