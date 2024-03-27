# Update and upgrade system packages
echo "\n====== Updating and upgrading packages ======\n"
sudo apt update -y
sudo apt upgrade -y

# Install Ollama and its models
echo "\n====== Installing Ollama ======\n"
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama2

# Install python3-pip
echo "\n====== Installing python3-pip ======\n"
sudo apt install python3-pip -y

# Install Flask and Ollama Python packages
echo "\n====== Installing Flask and Ollama Python packages ======\n"
pip install flask ollama

screen -S llaminator -m -d  python3 main.py
echo "====== now running ======> "
echo -e " _     _                 _             _             \n| |   | |               (_)           | |            \n| |   | | __ _ _ __ ___  _ _ __   __ _| |_ ___  _ __ \n| |   | |/ _\` | '_ \` _ \\| | '_ \\ / _\` | __/ _ \\| '__|\n| |___| | (_| | | | | | | | | | | (_| | || (_) | |   \n\\_____/_|\\__,_|_| |_| |_|_|_| |_|\\__,_|\\__\\___/|_|   \n                                                     \n                                                     "

