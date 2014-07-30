name             'madscience-vagrant-cookbook'
maintainer       'Noah Gibbs'
maintainer_email 'the.codefolio.guy@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Vagrant for the MadScience stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'windows'
supports 'mac_os_x'

# Joshua Timberman's Vagrant and VirtualBox cookbooks
depends 'vagrant-cookbook'
depends 'virtualbox-cookbook'
