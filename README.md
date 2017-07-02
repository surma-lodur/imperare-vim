# imperare-vim

Cross-Platform Vim Distribution.
This distributions main goal is a lightweigt and easy installable Vim distributions.
Therefore they will get more and more start help to switch to vim within this distribution.

# Tutor

There exists a tutor, which gudes you through the differend plugins and Vim commands.

The search has different difficulty parts.

    :help easy
    :help medium
    :help hard



## Requirements

Windows/Linux and Mac supported.

The only hard required tool are git.
So you need the git executable in your search path.

Check this into Mac/Linux/Unix int your terminal or in Windows via Powershell or cmd.

### Windows

Every required Third Party requirement will be downloaded to the subdir vim/bin.
The §PATH will not been adjust.

### Linux

install ctags and ag

    aptitude install ctags ag

### Mac

TBD

### Optional

For display a correct Powerline download and install one of the Powerline Fonts:

[https://github.com/powerline/fonts Powerline Fonts]

## Setup

Be sure that you don't have any .vim.old .vimrc.old .gvimrc.old in your
home directory.

Then do

    git clone git@github.com:surma-lodur/imperare-vim.git 
    cd imperare-vim
    ./install.sh
    or ./install.ps1


## Roadmap

* Autoupdate for Vundle without remove initialeasy setup
* Shortcut help for used Plugins
* Theme toggle script instead of change backgound

## Advanced

### Install new Plugins 

Open vim and type :PluginInstall
If everything was correct configured, the installation will be successfully be done in
vim itself.

And now you're ready to go!

### Update Plugins

Open vim and type :PluginUpdate.
If the update are completed, you can watch the changelogs with u.

Enjoy your updates.

### Customization

You can add your own configurations in ~/.vimrc.local to customize the config to your needs.
