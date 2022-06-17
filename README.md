# TermuxScripts

```bash
===============================
___  ___  __
 |  |__  |__)  |\/| |  | \_/
 |  |___ |  \  |  | \__/ / \

 __   __   __     __  ___  __
/__` /  ` |__) | |__)  |  /__`
.__/ \__, |  \ | |     |  .__/
______________________________
Project by
dmdhrumilmistry
______________________________
```

## Scripts

- Installation Scripts
  |Script Name|Description|
  |:---------:|:----------|
  |[Beef](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/Beef/beef-installer.sh)|Installs Beef Framework on Termux|
  |[cryptography](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/cryptography.sh)|Helps to install cryptography python package|
  |<details><summary>[Install Linux Distros](https://github.com/dmdhrumilmistry/TermuxScripts/tree/main/Installation/linux_distros)</summary><br>[Ubuntu](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/linux_distros/ubuntu.sh)</details>|Installation Scripts to install linux distros in Termux without Root|
  |[TOR WebServer](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/tor_webserver.sh)|Installs and configures apache2 webserver to host a website on TOR network|
  |[Ngrok](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/ngrok_installation.sh)|Installs ngrok on Termux|
  |[GooglePhish](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/GooglePhish.sh)|Installs Google Phishing Page Project on Termux|
  
## Installation

- Install **TermuxScripts** project

  ```bash
  bash -c "$(curl -fsSL https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/installer.sh?raw=True)"
  ```

- Provide `termux-scripts.py` permission for execution if missing

  ```bash
  chmod +x TermuxScripts/termux-scripts.py
  ```

## Usage

- Start UI using

    ```bash
    python termux-scripts.py
    ```

    _OR_

    ```bash
    ./termux-scripts.py
    ```

- Use help menu for options

    ```
    >> help
    +---------+----------------------------------------------+
    | Command | Description                                  |
    +---------+----------------------------------------------+
    |   help  | prints commands along with description       |
    |   exit  | exits TermuxScripts console                  |
    |  clear  | clears console                               |
    |   show  | print options in current directory           |
    |  select | selects a directory, eg. select Installation |
    |   back  | move one directory back                      |
    |   run   | runs a script eg. run GooglePhish.sh         |
    +---------+----------------------------------------------+
    ```

- To run `GooglePhish.sh` scripts from `Installation` scripts use:

  ```bash
  >> show
  +--------------+-----------------------+---------------+
  |     Dir      |         Files         | Dirs          |
  +--------------+-----------------------+---------------+
  |      .       |      installer.sh     | .git          |
  |              |                       | Installation  |
  | Installation |     GooglePhish.sh    | Beef          |
  |              |    cryptography.sh    | linux_distros |
  |              | ngrok_installation.sh |               |
  |              |    tor_webserver.sh   |               |
  +--------------+-----------------------+---------------+
  >> select Installation 
  >> run GooglePhish.sh
  ```

- To insta

## License

[MIT License](https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/LICENSE)

## Contributions

- Fork this project
- Update project
- Create Pull Request
- PR will be merged after reviewing the commits
