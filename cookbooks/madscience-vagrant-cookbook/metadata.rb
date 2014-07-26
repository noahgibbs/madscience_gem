name             'madscience-vagrant-cookbook'
maintainer       'Noah Gibbs'
maintainer_email 'the.codefolio.guy@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures Vagrant for the MadScience stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'debian', '>= 6.0'
supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 6.3'

depends 'vagrant-cookbook' # Joshua Timberman's vagrant cookbook
