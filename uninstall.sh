# Note: this uninstalls Vagrant, NOT the madscience gem.
sudo rm -rf /usr/bin/vagrant /opt/vagrant /Applications/Vagrant
sudo pkgutil --forget com.vagrant.vagrant

# And this should uninstall VirtualBox. Script copied from
# VirtualBox DMG uninstaller.
./VirtualBox_Uninstall.tool --unattended
