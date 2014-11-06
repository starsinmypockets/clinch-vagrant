Credits: Based on fork of semmypurewal/node-dev-bootstrap

Instructions:

• Install Virtual Box: https://www.virtualbox.org/wiki/Downloads

• Install Vagrant: https://www.vagrantup.com/downloads.html

• clone this repository: git clone git@github.com:starsinmypockets/clinch-vagrant.git

• from repository directory, run install script with two arguments (/path/to/parent/folder and projName). The app will take up to 10 minutes to install:

    $ /repos/clinch-vagrant/install.sh /path/to/parent/ projName

• Project codebase lives at /path/to/parent/projName/app

• From project root (/path/to/parent/projName), access virtual machine with:

    $ vagrant ssh

• visit project at http://localhost:3000

Knows Issues
------------
No inbound socket events are working, so you'll need to reload to check updated states.
