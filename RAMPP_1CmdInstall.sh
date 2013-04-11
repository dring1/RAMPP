#!bin/bash/



# 
# 1 click installation for 64-bit systems
# requires internet connection
# approximately 1GB installation -> dependencies inclusive
# lock out user from interferring with installation
# install all dependencies
# add scripts to user profile so on load the server starts

sudo apt-get update

echo "Installing : cURL "
sudo apt-get install -y curl

#installs ruby version controller
# allows for legacy ruby to be used
echo "Installing RVM"
curl -L get.rvm.io | bash -s stable

#ensures the rvm ruby env is activated on system log in
echo [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" >> ~/.bash_profile
echo [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" >> ~/.bashrc
#download all the dependencies for rails
source ~/.rvm/scripts/rvm
sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion libgdbm-dev libffi-dev git-core
#enables adding a repo as sudo alias wihout hitting enter
echo | sudo apt-add-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs
rvm install 1.9.3
source ~/.rvm/scripts/rvm
rvm use 1.9.3 --default
ruby -v
echo [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
gem install rails
source ~/.rvm/scripts/rvm
echo "Installing : XAMPP"
echo "64-bit system requires 32-bit libraries"
sudo apt-get install ia32-libs
wget http://www.apachefriends.org/download.php?xampp-linux-1.7.3a.tar.gz
sudo tar xvfz download.php?xampp-linux-1.7.3a.tar.gz -C /opt

#must use my edited lampp file inorder to use on 64 bit
#systems removes conflicts with OS if it is 64 bit OS so long as the 32 bit
# OS libraries are installed
echo "Replacing Existing lampp script"
sudo cp src/lampp /opt/lampp/lampp


echo "Enabling auto-start for xampp"

#copy file to init.d which contains files execute on start
sudo cp src/start_lampp.sh /etc/init.d/
#give sudo access to the file to allow the OS to execute without require kernel mdoe
sudo chmod +x /etc/init.d/start_lampp.sh
#add the file to files required to launch on start up
sudo update-rc.d -f start_lampp.sh defaults

echo "Rebooting system"
#sudo /sbin/reboot 
