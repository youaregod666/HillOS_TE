## IMineOS TE has released!

Hello again, dear friend. Thank you for being with us and supporting our ideas throughout the long development cycle. IMineOS TE has finally reached the release stage: now it is a completely independent operating system with its own development API and wonderful [illustrated wiki](https://github.com/IgorTimofeev/MineOS/wiki) of it's usage. 
IMineOS TE is a GUI based operating system for the OpenComputers Minecraft mod. It has extensive and powerful customisation abilities.
## Here's a list of a few features:

-   Multitasking
-   Double buffered graphical user interface
-   Language packs and software localization
-   Multiple user profiles with password authentication
-   Own EEPROM firmware with boot volume choose/format/rename features and Internet Recovery mode
-   File sharing over the local network via modems
-   Client connections to real FTP servers
-   An internal IDE with syntax highlighting and debugger
-   Error reporting system with the possibility to send information to developers
-   Animations, wallpapers, screensavers, color schemes and huge customization possibilities
-   Open source system API and detailed illustrated documentations

## How to install?

The easiest way is to use default **pastebin** script. Insert an OpenOS floppy disk to computer, insert an Internet Card, turn computer on and type the following to console to install IMineOS TE:

	pastebin run Yrys52mW

You can paste it to console using middle mouse button or insert key (by default). If for some reason the pastebin method isn't available to you (for example, it's blacklisted on game server or blocked by Internet provider), use alternative command to download the installer directly from the Github page:

	wget -f https://raw.githubusercontent.com/youaregod666/IMineOS-TE/master/Installer/BIOS.lua /tmp/bios.lua && flash -q /tmp/bios.lua && reboot

After a moment, a nice system installer will be shown. You will be prompted to select your preferred language, boot volume (can be formatted if needed), create a user profile and customize some settings

## How to create applications and work with API?

[Wiki by IgorTimofeev](https://github.com/IgorTimofeev/MineOS/wiki)

## Rights
 
 All rights to [IgorTimofeev](https://github.com/IgorTimofeev)
