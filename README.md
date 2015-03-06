# MadScience

The MadScience stack helps deploy your Rails application from a Mac or Linux
development machine to a new local VM and a matching production environment.
It uses Vagrant, Chef and Capistrano. It stores deployment credentials under
your home directory in the .deploy_credentials subdirectory.

The Mad Science Stack is based on a class called Rails Deploy In An Hour
(http://rails-deploy-in-an-hour.com), a paid product. This code is MIT
licensed, however, and can be used according to that license.

The Mad Science Stack assumes your sensitive deployment information (SSH keys,
passwords, etc.) is in ~/.deploy_credentials. Much of it will be created if it
doesn't exist, but you'll need to fill in your own passwords for external
services like email, your own AWS deploy keys and so on if you need them.

When in doubt, run setup and look in the deploy credentials directory and
nodes/all_nodes.json.erb in the deploy repository. You can also read
documentation in the MadScience project Wiki:
https://github.com/noahgibbs/madscience/wiki

It's also possible to purchase an online class with additional videos, example
configurations and documentation at "http://rails-deploy-in-an-hour.com" if you wish.

## Tool Versions

Each version of the Mad Science Stack is tested with a specific version of
each tool. The current version of the Mad Science Stack, Version 0.0.1,
installs and uses other specific tool versions, in this case:

* Chef: 12.0.3
* Librarian-Chef: 0.0.3
* Knife-Solo: 0.4.2
* Vagrant: 1.7.1
* Vagrant-Omnibus: 1.4.2
* VirtualBox: 4.3.12

Note that this doesn't include the tools that are (usually) deployed to like
NGinX, Ubuntu Linux and so on -- those depend on the deploy repository.

Not all of this software is used by every deploy repository. For instance,
Capistrano can be optional. But if you use it with a given version of
MadScience, that's the version we've tested with.

## Requirements

The MadScience stack also assumes you have these installed:

* Bundler and RubyGems (some recent version)
* SSH
* A git repo to deploy, unless you just want the sample app

A deploy repo will also use a number of specific gem and cookbook versions, of
course.

## Installation

Add 'madscience' to your Gemfile or install it manually:

    gem install madscience

You'll also need Git and SSH installed already.

It's possible to clone this repo and run madscience locally, too.

After madscience has been run, you can clone the default madscience deploy
repository under the current directory, and create a new (development) VM:

    rvmsudo madscience setup_clone_and_deploy  # with RVM
    # OR sudo madscience setup_clone_and_deploy # with no RVM

You can also just install the tools without cloning a new repo or deploying it automatically.

    rvmsudo madscience setup # with RVM
    # OR sudo madscience setup # with no RVM

And if you want a one-liner for your organization, you can specify a different
deploy repository:

    MADSCIENCE_REPO=git://my.org/path_to_my_repo rvmsudo madscience setup_clone_and_deploy

If you're really gung-ho and have your deploy credentials directory set up
already, you can even clone and deploy to real hosting:

    MADSCIENCE_REPO=git://my.org/path_to_my_repo MADSCIENCE_PROVIDER=aws rvmsudo madscience setup_clone_and_deploy

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
deploy credentials directory no matter how many Rubies or deploy repositories you have.

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
    sudo rm -rf cookbooks/*  # Blow away root-owned cookbooks on later runs
    librarian-chef install
    rvmsudo bundle exec bin/madscience setup  # Whichever command you're testing

## Problems?

It's easy to get permissions problems. You're running some commands as sudo, and other commands not as sudo. When this happens, the first thing to do is to blow away (with sudo) the cookbooks directory:

   sudo rm -rf cookbooks/*

## License

* Author:: Noah Gibbs (the.codefolio.guy@gmail.com)
* Vagrant-Cookbook copyright 2013-2014 Joshua Timberman, Apache 2.0 License
* Virtualbox-Cookbook copyright 2013-2014 Joshua Timberman, Apache 2.0 License
* Everything else (C) Noah Gibbs, 2014-2015

With the exception of Joshua Timberman's cookbooks, this code is under the MIT
license.

## Contributing

1. Fork it ( http://github.com/noah.gibbs/madscience/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
