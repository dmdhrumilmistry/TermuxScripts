# Linux Distro Installers for Termux

## Linux Distros

Copy and Paste below command to install respective distro

- Ubuntu
  ```bash
  cd $PREFIX/tmp && curl -L -o "ub-installer.sh" "https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/linux_distros/ubuntu.sh?raw=True" && bash ub-installer.sh && rm ub-installer.sh && cd $HOME
  ```

- Multiple Linux Distribution Installer
  - Alpine 
  - Arch Linux
  - Debian
  - Fedora
  - Manjaro
  - OpenSuse
  - Ubuntu
  - Void Linux
  ```bash
  cd $PREFIX/tmp && curl -L -o "linux_distros_installer.sh" "https://github.com/dmdhrumilmistry/TermuxScripts/blob/main/Installation/linux_distros/linux_distros.sh?raw=True" && bash linux_distros_installer.sh && rm linux_distros_installer.sh && cd $HOME
  ```
