# Installing the civil-claims alpha on your macbook.

- Install XCode from the mac App Store
- Run XCode, open `Preferences` -> `Downloads` and install the `Command Line Tools`

- Open terminal.app and run, in order:

```
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" # install brew
  
brew doctor # check brew installation

curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enabled # install RVM  

source ~/.bash_profile
```

- Install http://postgresapp.com/

- After installation, click the elephant icon in the task bar and select `open psql`

- In the terminal window that opens, type:
`create database pcol_dev;`
After a brief pause, it should say 'CREATE DATABASE.


- You'll need an account on `github.com` if you don't already have one. Speak to a DSD team developer to get your account linked to the MoJ organisation on Github.

- In terminal.app, enter each of the following lines followed by enter.

```
mkdir ~/Sites  
cd ~/Sites  
git clone git@github.com:ministryofjustice/civil-claims.git  
cd civil-claims  
bundle install  
rake db:migrate  
rake db:seed  
rails s  
```
  
- Hopefully this last command will give an output like this:  

```
$ rails s  
=> Booting WEBrick  
=> Rails 4.0.0 application starting in development on http://0.0.0.0:3000  
=> Run `rails server -h` for more startup options  
=> Ctrl-C to shutdown server  
[2013-07-30 14:01:23] INFO  WEBrick 1.3.1  
[2013-07-30 14:01:23] INFO  ruby 2.0.0 (2013-06-27) [x86_64-darwin12.4.0]  
[2013-07-30 14:01:23] INFO  WEBrick::HTTPServer#start: pid=2374 port=3000  
```

- If this is the case, you can access your local copy of the Civil Claims alpha prototype at the folllowing URL: `http://localhost:3000`
 
- If it didn't work out quite like that, you might want to consider speaking to one of the DSD development team.

- If you reboot your laptop, you'll need to restart the application. Do it in terminal.app, like this:  
```
cd ~/Sites/civil-claims
rails s
```

