#
# Cookbook Name:: madscience-vagrant-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

##### First, Install Vagrant and VirtualBox with appropriate versions and plugins.

# Default attributes in a cookbook override default
# attributes in an attributes file, like the one
# in vagrant-cookbook/attributes/default.rb.
node.default['vagrant']['version'] = '1.7.1'
node.default['vagrant']['plugins'] = [
  { 'name' => 'vagrant-omnibus', 'version' => '1.4.1' },
  { 'name' => 'vagrant-librarian-chef', 'version' => '0.2.1' },
  { 'name' => 'vagrant-aws', 'version' => '0.6.0' },
  { 'name' => 'vagrant-digitalocean', 'version' => '0.7.3' },
  { 'name' => 'vagrant-linode', 'version' => '0.1.1' },
  { 'name' => 'vagrant-host-shell', 'version' => '0.0.4' },
]

case node['platform_family']
when 'fedora'
  if node['kernel']['machine'] == 'x86_64'
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_64.rpm'
  else
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_32.rpm'
  end
when 'rhel'
  if node['kernel']['machine'] == 'x86_64'
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_64.rpm'
  else
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_32.rpm'
  end
when 'debian'
  if node['kernel']['machine'] == 'x86_64'
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_64.deb'
  else
    node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1_x86_32.deb'
  end
when 'windows'
  # TODO: find real MSI version
  node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1.msi'
when 'mac_os_x'
  node.default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.1.dmg'
else
  raise "Don't recognize OS family: #{node['platform_family'].inspect}!"
end

# URL sometimes seems not to be properly chosen by Vagrant cookbook

# I'm not going to require curl, but for this version of Vagrant, this is the output of
# "curl -L https://dl.bintray.com/mitchellh/vagrant/1.7.1_SHA256SUMS?direct"
curl_output = <<-CURL
eaeb3ad6624ccaeaefa6fc7a77a2f5d9640ef9385c5eeebdb90602d5f2011176  vagrant_1.7.1.dmg
abab1db382be4c5d6b1e5aad96fb0909a559c3e500c5b2eb3f0c9178de7d1ac5  vagrant_1.7.1.msi
4396385d3493931634c5f12e464a991f75f36c93783d392c60100112ec3d406d  vagrant_1.7.1_i686.deb
6e405a855c4426b04f568f62740f04025c548b2f722a4b3faee94b0b2ce19bc0  vagrant_1.7.1_i686.rpm
6615b95fcd8044e2f5e1849ec1004df5e05e390812558ec2c4b3dcec541b92da  vagrant_1.7.1_x86_64.deb
b66be4b8f7921f59b00c186344c8501f97a26e172e94c3add7298b5147bcab27  vagrant_1.7.1_x86_64.rpm
CURL
vagrant_package_name = node.default['vagrant']['url'].split("/")[-1]
check_line = curl_output.split("\n").detect { |line| line[vagrant_package_name] }
node.default['vagrant']['checksum'] = check_line.split(" ")[0]

case node['platform_family']
when 'mac_os_x'
  node.default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.24/VirtualBox-4.3.24-98716-OSX.dmg'
when 'windows'
  node.default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.20/VirtualBox-4.3.20-96996-Win.exe'
  node.default['virtualbox']['version'] = Vbox::Helpers.vbox_version(node['virtualbox']['url'])
when 'debian', 'rhel'
  node.default['virtualbox']['version'] = '4.3'
end


# The Vagrant cookbook assumes it can find Vagrant as a first-in-path binary.
# That mean /usr/bin has to be present and before any other path that might
# have vagrant in it.
ENV['PATH'] = "/usr/bin:#{ENV['PATH']}"
include_recipe "vagrant"
include_recipe "virtualbox"

# HIDEOUS WORKAROUND:
# If you've previously installed Vagrant and manually uninstalled, the Vagrant
# installer will simply fail to install, quietly. D'oh!
# You have to manuall remove the package: sudo pkgutil --forget com.vagrant.vagrant
# But there are other reasons this could happen, so escalate to the user :-(
ruby_block "See if Vagrant just didn't install" do
  block do
    if !File.exist? "/opt/vagrant" || Dir["/opt/vagrant"].empty?
      raise "Vagrant failed to install, but didn't raise an error! Uninstall manually and try again! http://docs.vagrantup.com/v2/installation/uninstallation.html"
    end
  end
end

# HIDEOUS WORKAROUND:
# When the phase of the moon is wrong, the Vagrant cookbook will
# install plugins to its own satisfaction, but they won't show up in
# "vagrant plugin list" or actually work. But re-running the Vagrant
# cookbook doesn't help, it thinks it's installed. Until debugged,
# escalate to user.
#
# Are you a user? If so, you can fix this by manually installing
# whatever plugins you don't see in "vagrant plugin list", from
# the set of node.default['vagrant']['plugins'] above. Be sure
# to install with the version given, like this:
#
# vagrant plugin install vagrant-whatever-plugin --plugin-version 1.2.3

ruby_block "See if Vagrant plugins just didn't install" do
  ALL_PLUGINS = node.default['vagrant']['plugins'].map { |row| row['name'] }
  block do
    output = `/usr/bin/vagrant plugin list` || ""
    missing_plugins = ALL_PLUGINS.select { |p| !output[p] }
    unless missing_plugins.empty?
      raise "Vagrant plugins not installed correctly: #{missing_plugins.inspect}! Uninstall Vagrant and re-run :-(   http://docs.vagrantup.com/v2/installation/uninstallation.html"
    end
  end
end

##### Second, set up a local directory of deploy credentials if not already present.

# TODO: Test this on Windows
homedir = ENV['HOME'] || ENV['userprofile']
creds_dir = File.join(homedir, ".deploy_credentials")

# TODO: what's this on Windows?
user = ENV['SUDO_USER'] || ENV['USER']

directory creds_dir do
  owner user
  mode "0700"
end

# TODO: what is Windows equivalent?
execute "generate ssh provisioning keys for #{user}." do
  user user
  creates File.join(creds_dir, "id_rsa_provisioning_4096.pub")
  command "ssh-keygen -t rsa -q -b 4096 -f #{File.join creds_dir, "id_rsa_provisioning_4096"} -P \"\""
end

execute "generate ssh app-deploy keys for #{user}." do
  user user
  creates File.join(creds_dir, "id_rsa_deploy_4096.pub")
  command "ssh-keygen -t rsa -q -b 4096 -f #{File.join creds_dir, "id_rsa_deploy_4096"} -P \"\""
end

cookbook_file "digital_ocean.json" do
  owner user
  path File.join(creds_dir, "digital_ocean.json")
  action :create_if_missing
end

cookbook_file "aws.json" do
  owner user
  path File.join(creds_dir, "aws.json")
  action :create_if_missing
end

cookbook_file "linode.json" do
  owner user
  path File.join(creds_dir, "linode.json")
  action :create_if_missing
end

file File.join(creds_dir, "authorized_keys") do
  user user
  action :create_if_missing
  manage_symlink_source true
  content { File.read(File.join(creds_dir, "id_rsa_provisioning_4096.pub")) }
end
