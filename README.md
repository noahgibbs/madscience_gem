# MadScience

The MadScience stack helps deploy your Rails application to a new local VM and
a matching production environment.  It uses Vagrant, Chef and Capistrano. It
stores deployment credentials under your home directory in the
.deploy_credentials subdirectory.

The Mad Science Stack is based on a class called Ruby Mad Science
(http://rubymadscience.com), a paid product.

Each version of the Mad Science Stack is tested with a specific version of
each tool. The current version of the Mad Science Stack, Version 0.0.1,
installs and uses these other specific tool versions:

   Chef: 11.12.8
   Librarian-Chef: 0.0.3
   Knife-Solo: 0.4.2
   Vagrant: 1.6.3
   Vagrant-Omnibus: 1.4.2
   VirtualBox: 4.3.12
   Capistrano: 3.2.1
   Capistrano-Rails: 1.1.1
   Capistrano-Bundler: 1.1.2
   Capistrano-RVM: 0.1.1
   SSHKit: 1.5.1

Note that this doesn't include the tools that are (usually) deployed to like
NGinX, Ubuntu Linux and so on -- those depend on the deploy repository.

Not all of this software is used by every deploy repository. For instance,
Capistrano can be optional. But if you use it with a given version of
MadScience, that's the version being used.

The MadScience stack also has these dependencies:
Bundler and RubyGems (some recent version)
SSH
A git repo to deploy, unless you just want the sample app

A deploy repo will also use a number of specific gem and cookbook versions, of
course.

## Installation

Add 'madscience' to your Gemfile or install it manually:

   gem install madscience

You'll also need Git and SSH installed already.

It's possible to clone this repo and run madscience locally, too.

## Usage

After you've installed the Mad Science gem ("gem install madscience"), you'll
want to run the setup command:

   sudo madscience setup
   # OR, with rvm:
   rvmsudo madscience setup # this leaves RVM's env vars set properly

This will install, help install or check versions of all software in the
currently installed Mad Science Stack version. It will get you set up
correctly or complain if it can't. Make sure to use the right Ruby if you're
using a version manager (RVM, chruby, rbenv, etc.)

It will also set up initial deploy credentials such as SSH keys. You can
modify the results in ~/.deploy_credentials if you like. The default setup is
meant to be tolerably secure and fairly convenient. You only need one
~/.deploy_credentials directory no matter how many Rubies you have.

### Cloning

The setup command will set up basic deployment credentials if you don't have
them. It will also set up VirtualBox and Vagrant, and install the appropriate
tools and gems.

However, you'll still need a deploy repo - code that's specific to your setup,
including what host to install to, what Chef cookbooks to use and where to
find your application.

There's a default one (NOTE: currently it's a private repo! There will be a
public repo for this later.) Or you can set the MADSCIENCE_REPO environment
variable to customize what repo to clone from, or just clone the repo
yourself, locally.

   # No sudo here, you don't want root (admin) to own these files
   madscience clone

This will clone and configure a new repository which you can configure for
your app(s).

### Implementation

The setup command will run Chef locally on your development machine. So it'll
leave behind a Chef temp directory (/var/chef on Linux or Mac OS X machines.)
That's also why you need to run it as the administrator -- that and the fact
that you're installing virtualization software, of course.

### Running locally

If you've cloned the madscience gem from GitHub and don't have it installed,
you'll want to run it like this:

   # No RVM? Change "rvmsudo" to "sudo"
   bundle install
   librarian-chef install
   rvmsudo bundle exec bin/madscience setup
   bundle exec bin/madscience clone

## License

* Author:: Noah Gibbs (the.codefolio.guy@gmail.com)
* Vagrant-Cookbook copyright 2013-2014 Joshua Timberman, Apache 2.0 License
* Virtualbox-Cookbook copyright 2013-2014 Joshua Timberman, Apache 2.0 License
* Everything else (C) Noah Gibbs, 2014

With the exception of Joshua Timberman's cookbooks, this code is under the MIT
license.

## Contributing

1. Fork it ( http://github.com/noah.gibbs/madscience/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
