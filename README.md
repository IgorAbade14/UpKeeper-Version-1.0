# 🛠️ UpKeeper v1.0

UpKeeper is a smart automation tool designed for **Linux Mint** (Debian/Ubuntu based systems) that manages monthly maintenance tasks. It ensures your system stays updated without being intrusive, using a friendly graphical interface.

## 🚀 Features
* **Intelligent Scheduling:** Only suggests updates on weekends (Saturday or Sunday).
* **Execution Tracking:** Remembers if the update was already performed in the current month to avoid redundant prompts.
* **GUI Integration:** Uses **Zenity** to provide a clean, user-friendly dialogue box.
* **Real-time Monitoring:** Automatically opens a terminal to show the progress of `apt update` and `apt upgrade`.

## 📂 Project Structure
* `UpKeeper.sh`: The main script containing the automation logic.
* `config/`: Directory where the execution state (`ultimo_mes.txt`) is stored.
* `logs/`: Directory for maintenance history (ignored by git).

## 🛠️ Requirements
* **OS:** Linux Mint / Ubuntu / Debian.
* **Dependencies:** `zenity`, `bash`, `gnome-terminal`.

## 📖 How to Use
1. Clone this repository:
   ```bash
   git clone [https://github.com/IgorAbade14/UpKeeper-Version-1.0.git]```

2. Give execution permission to the script with Bash:

* username/home: ~/UpKeeper$
* username/home: ~/UpKeeper$ chmod +x UpKeeper.sh 

And run the script!

* username/home: ~/UpKeeper$ ./UpKeeper.sh

## 🧠 Learning Journey
* This project was developed as part of my DevOps learning path. It covers:
* Bash Scripting & Logic.
* Standard Output (STDOUT) and Error (STDERR) redirections.
* State management using local files.
* Version control with Git and GitHub.



## 👨‍💻  Developed by
 `[https://github.com/IgorAbade14]`
