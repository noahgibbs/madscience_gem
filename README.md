# MadScience

This gem helps deploy your Rails application to Vagrant and production.  It's
based on the Mad Science Stack of tools, including Chef and Capistrano. It
stores deployment credentials under your home directory in
~/.deploy_credentials.

The Mad Science Stack is based on Ruby Mad Science
(http://rubymadscience.com), a paid product, but this gem and the Mad Science
Stack are entirely open-source and free to use, forever.

Mad Science Stack components are versioned together. The current version
of the Mad Science Stack, Version 0.0.1, installs and uses these versions:

Chef: 11.12.8
Librarian-Chef: 0.0.3
Knife-Solo: 0.4.2
Vagrant: 1.6.3
Vagrant-Omnibus: 1.4.2
VirtualBox: 4.3.12
Capistrano: 3.2.1
Capistrano-Rails: 1.1.1
Capistrano-Bundler: 1.1.2
SSHKit: 1.5.1

It also has these dependencies:
MRI (plain) Ruby: 1.9.3 or higher, 2.0+ is great
Bundler and RubyGems: recent
Git
SSH

Plus a number of specific gem and cookbook versions, of course, and many
Ubuntu packages whose versions are *not* strictly controlled. It's
surprisingly hard to mass-'lock' Ubuntu package versions in Chef or Puppet,
even ignoring the security concerns with doing so.

## Installation

Add 'madscience' to your Gemfile or install it manually:

    $ gem install madscience

You'll also need Git and SSH installed already.

## Usage

After you've installed the Mad Science gem ("gem install madscience"), you'll
want to run the setup command:

> madscience setup

This will install, help install or check versions of all software in the
currently installed Mad Science Stack version. It will get you set up
correctly or complain if it can't. This only does setup for the current
Ruby version if you're using a version manager (RVM, chruby, rbenv, etc.)

It will also set up initial deploy credentials such as SSH keys. You can
modify the results in ~/.deploy_credentials if you like. The default setup is
meant to be tolerably secure and fairly convenient. You only need one
~/.deploy_credentials directory no matter how many Rubies you have.

If you don't already have a Mad Science Stack deploy repo containing your
Vagrantfile and Chef configuration, run the clone command:

> madscience clone

This will create a new repository which you can configure for your Rack
app(s).

## License

MIT license - see LICENSE.txt.

## Contributing

1. Fork it ( http://github.com/noah.gibbs/madscience/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
