# Note: this uninstalls Vagrant, NOT the madscience gem.
sudo rm -rf /usr/bin/vagrant /opt/vagrant /Applications/Vagrant
sudo pkgutil --forget com.vagrant.vagrant

# Remove root's vagrant dir and current user's vagrant dir
sudo rm -rf /var/root/.vagrant.d
rm -rf ~/.vagrant.d

# And this should uninstall VirtualBox. Script copied from
# VirtualBox DMG uninstaller.
./VirtualBox_Uninstall.tool --unattended
