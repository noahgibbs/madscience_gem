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
node.default['vagrant']['plugins'] = [ 'vagrant-omnibus', 'vagrant-librarian-chef', 'vagrant-aws', 'vagrant-digitalocean', 'vagrant-linode', 'vagrant-capistrano' ]

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

case node['platform_family']
when 'mac_os_x'
  node.default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.20/VirtualBox-4.3.20-93733-OSX.dmg'
when 'windows'
  node.default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.20/VirtualBox-4.3.20-93733-Win.exe'
  node.default['virtualbox']['version'] = Vbox::Helpers.vbox_version(node['virtualbox']['url'])
when 'debian', 'rhel'
  node.default['virtualbox']['version'] = '4.3'
end


# This will include the OS-appropriate recipe
include_recipe "vagrant"
include_recipe "virtualbox"

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

file File.join(creds_dir, "authorized_keys") do
  user user
  action :create_if_missing
  content { File.read(File.join(creds_dir, "id_rsa_provisioning_4096.pub")) }
end
