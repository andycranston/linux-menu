# Linux Menu - a simple menu shell script

## Short video

Here is a short (less than two minutes long) video on YouTube:

[A simple Linux menu command](https://youtu.be/FwN5_d1TjH4)

showing you the simple Linux menu command in action.

## Quick Start

Do this all as a normal user - i.e NOT the root user or with sudo.

Ensure you have a "bin" subdirectory under your home directory.

```
mkdir $HOME/bin
```

Make sure that you have write access to your $HOME/bin directory:

```
chmod u+w $HOME/bin
```

Ensure $HOME/bin is in your PATH environment variable.

Clone the github repo:

```
cd /var/tmp
git clone https://github.com/andycranston/linux-menu.git
cd linux-menu
```

Run the install script:

```
./Install.sh
```

Create a file called:

```
$HOME/.00menu.conf
```

with the following content:

```
1: uptime
2: uname -a
3: ip address show | cat | more
```

Run:

```
menu
```

And the menu options above should be displayed.

Entered the option number to run the item.

Enter the single character 'q' to quit the menu.





## Context menus

The menu script looks first in the current directory for a file called
.00menu.conf to use. If that does not exist it will try $HOME/.00menu.conf
and if that does not exist the menu script will display an error.

This means you can create "context based" menus depending on the current
directory.

For example if you are in directory `/etc/kea` you may wish to have a
menu file:

```
/etc/kea/.00menu.conf
```

with this content:

```
1: sudo systemctl status kea-dhcp4-server.service | cat
2: sudo systemctl stop   kea-dhcp4-server.service
3: sudo systemctl start  kea-dhcp4-server.service
```

So typing:

```
cd /etc/kea
menu
```

Will show a menu with specific (i.e. "context" related to the current
directory /etc/kea) options for doing things with the Kea DHCP software
service.


## Menus of menus

If you have two context menus in the following locations:

```
/etc/kea/.00menu.conf
/etc/unbound/.00menu.conf
```

You can create a "main" menu in:

```
$HOME/.00menu.conf
```

with this content:

```
1: (cd /etc/kea ; menu)
2: (cd /etc/unbound ; menu)
```

So typing "menu" after logging will give you a menu to choose either
the Kea based context menu or the Unbound based context menu.

## Some detail

Options must be integers and immediately followed by a colon ':'
character.

You can put comments (beginning with a hash '#' character) and blank lines
in the .00menu.conf file. These will NOT be displayed by the menu command.

If you do want blank lines then enter a line with some whitespace
(e.g. three spaces).

----------------
End of README.md
