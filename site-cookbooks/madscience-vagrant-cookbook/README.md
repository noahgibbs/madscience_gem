madscience-vagrant-cookbook Cookbook
====================================
This cookbook sets up your local development machine for the MadScience deploy
stack. This includes Chef, Vagrant, Capistrano and many ancillary tools.

Requirements
------------
The cookbook requires Joshua Timberman's Vagrant and VirtualBox cookbooks.
However, this will normally only ever be used from inside the MadScience gem,
so those requirements should be met trivially.

Usage
-----
#### madscience-vagrant-cookbook::default

Normally you should use this via the madscience gem. Then run the "madscience
setup" command with administrative privileges. On Mac or Linux, that means
you'll type "sudo madscience setup" and then give your password if necessary.

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Noah Gibbs (the.codefolio.guy@gmail.com)

Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### madscience-vagrant-cookbook::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['madscience-vagrant-cookbook']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>
