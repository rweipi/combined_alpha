# Resetter v1.0.0-stable
![alt tag](https://github.com/gaining/Resetter/blob/master/Resetter/resetter-screenshot.png)

It is an application built with python and pyqt that will help to reset an Ubuntu, Linux-Mint, and some other distros to stock, without having to manually re-install by using a live usb/cd/dvd image. For the list of supported distros, please see the *Officially supported distros* section. 

# How does it work?
- Typical case of auto apps reset <br/>
installed programs list - updated manifest = non-default programs <br/>
updated manifest - installed programs list = MPIAs <br/>
reset = (Installed programs list - non-default programs) + MPIAs <br/>
There are other reset features, see features list.


# Status - stable
- The software is stable. Feedback will be greatly appreciated.
- Current version is 1.0.0-stable some major bug fixes and new features + improvements.
- Now that the stable version is out of the way, I will focus my time on building a CLI version which shouldn't take long. It will be written in python 3 this time.
- Please check the [changelog](https://github.com/gaining/Resetter/blob/master/changelog) for more details.

# How to install
Install via deb file found [here](https://github.com/gaining/Resetter/releases/tag/v1.0.0-stable). 

PPA will be created when I figure out how.
It is easier to install any deb files via gdebi, especially on elementary os with no graphical way of installing a deb file. 
On the terminal, run `sudo apt install gdebi`.
- Linux deepin isn't based on Ubuntu but on Debian so some modules are not available in their repos by default.

**For Linux Deepin Users** 
Before installing Resetter, fetch the add-apt-key package using `wget -c http://mirrors.kernel.org/ubuntu/pool/universe/a/add-apt-key/add-apt-key_1.0-0.5_all.deb` and install it with `sudo gdebi add-apt-key_1.0-0.5_all.deb`
# To Do 
- Official video tutorial on youtube
- Debian Jessie support (Top Priority)
- Make Resetter multilingual. (Will need help of volunteer translators) 
- I already have a volunteer Spanish translator on standby.
- Make an appimage as there are many reasons why Resetter needs to be portable.

# Bug reports | informe de error | rapport d'erreur | relatório de erro| 錯誤報告 | отчет об ошибке
- It's possible that you want to report a bug but don't speak or write in English? Don't worry! Send the bug report in your native language (to my email) and I will use a translator to decipher what you mean. 
- If you find a bug or problem please create an issue on github. 
- If you do not have a github account do not hesitate to contact me and send your bug report at gaining7@outlook.com.

# Options comparison

MPIA means missing pre-installed apps

<center>

| Features List                          | Option 1: Automatic Reset | Option 2: Custom Reset |
|----------------------------------------|:-------------------------:|:----------------------:|
| Auto remove apps for reset             |             ✓             |            ✓           |
| Choose which apps to remove for reset  |             ✗             |            ✓           |
| Remove old kernels                     |             ✗             |            ✓           |
| Choose to only delete user             |             ✗             |            ✓           |
| Delete users and home directories      |             ✓             |            ✓           |
| Choose which user to delete            |             ✗             |            ✓           |
| Create default backup user             |             ✓             |            ✓           |
| Create custom backup user              |             ✗             |            ✓           |
| Auto install MPIAs                     |             ✓             |            ✓           |
| Choose which MPIAs to install          |             ✗             |            ✓           |
| remove non-default users               |             ✓             |            ✓           |
| dependent package view                 |             ✗             |            ✓           |
| remove snap packages                   |             ✓             |            ✓           |


</center>

# Other features:
- Easy install: Basically, you will be able to build your own list of apps that you'd like to mass install after a reset or fresh install. It can also be used anytime to install a package. If you saved a backup file using the save feature prior to your reset or fresh install, you will be able to restore the apps from that list if they're available to install.

- Easy PPA: With this feature, you can search launchpad.net for PPAs containing apps directly from resetter and install it into your system. It will also grab the ppa's key automatically. This eliminates the need of using a terminal to add ppas from launchpad making distros more user friendly.

- Source Editor: It is a normal editor that can disable, enable, or remove ppas from a user's system but what makes this different from other source editors is that you can search for the ppa that you want to edit.

# Officially supported distros [64-bit]
- Linux Mint 18.1
- Linux Mint 18
- Linux Mint 17.3
- Ubuntu 17.04
- Ubuntu 16.10 
- Ubuntu 16.04
- Ubuntu 14.04
- Elementary OS 0.4 
- Debian jessie ~ delayed but will come via resetter-cli
- Linux Deepin 15.4 

# Donate
Please show your support by donating Resetter has helped you.
If you'd like your name to be on the donors list, I can arrange for that as well.

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=8FET8RGU2ZKQ8)

# Contact
- If you wish to contact me about anything else reach me via gaining7@outlook.com.

# Donors List - Thank you so much for your support and contribution
- Mez Pahlan - $10
