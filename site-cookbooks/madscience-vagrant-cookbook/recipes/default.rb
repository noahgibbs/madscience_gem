#
# Cookbook Name:: madscience-vagrant-cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Default attributes in a cookbook override default
# attributes in an attributes file, like the one
# in vagrant-cookbook/attributes/default.rb.
default['vagrant']['plugins'] = [ 'vagrant-omnibus' ]

case node['platform_family']
  when 'fedora'
    if node['kernel']['machine'] == 'x86_64'
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.rpm'
    else
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_32.rpm'
    end
  when 'rhel'
    if node['kernel']['machine'] == 'x86_64'
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.rpm'
    else
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_32.rpm'
    end
  when 'debian'
    if node['kernel']['machine'] == 'x86_64'
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb'
    else
      default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_32.deb'
    end
  when 'windows'
    # TODO: find real MSI version
    default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3.msi'
  when 'mac_os'
    default['vagrant']['url'] = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3.dmg'
  else
    raise "Don't recognize OS family: #{node['platform_family'].inspect}!"
  end
end

case node['platform_family']
when 'mac_os_x'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.12/VirtualBox-4.3.12-93733-OSX.dmg'
when 'windows'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.3.12/VirtualBox-4.3.12-93733-Win.exe'
  default['virtualbox']['version'] = Vbox::Helpers.vbox_version(node['virtualbox']['url'])
when 'debian', 'rhel'
  default['virtualbox']['version'] = '4.3'
end


# This will include the OS-appropriate recipe
include_recipe "vagrant-cookbook"
include_recipe "virtualbox-cookbook"
