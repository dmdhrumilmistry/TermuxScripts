# TermuxScripts


## Scripts
- Installation Scripts
  |Script Name|Description|
  |:---------:|:----------|
  |[cryptography](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/cryptography.sh)|Helps to install cryptography python package|
  |<details><summary>[Install Linux Distros](https://github.com/dmdhrumilmistry/TermuxScripts/tree/main/Installation/linux_distros)</summary><br>[Ubuntu](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/linux_distros/ubuntu.sh)</details>|Installation Scripts to install linux distros in Termux without Root|
  |[TOR WebServer](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/tor_webserver.sh)|Installs and configures apache2 webserver to host a website on TOR network|
  

## Usage
- replace [script_link] with desired script link and execute below command in termux
  ```bash
  curl -L -o "downloaded_script.sh" "[script_link]?raw=True" && bash downloaded_script.sh
  ```
  
- Example to install `cryptography python package` use
  ```bash
  curl -L -o "downloaded_script.sh" "https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/cryptography.sh?raw=True" && bash downloaded_script.sh
  ```
 
## License
[MIT License](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/LICENSE)
