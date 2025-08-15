#! /bin/bash
#
# @(!--#) @(#) Install.sh, version 001, 15-august-2025
#
# install the menu.sh script into $HOME/bin for a "non-root" user
#

set -u

#
# Main
#

ORIGINAL_PATH=$PATH

PATH=/bin:/usr/bin
export PATH

progname=`basename $0`

username=`id | cut -d'(' -f2 | cut -d')' -f1`

if [ "$username" == "root" ]
then
  echo "$progname: do NOT run this script as root user!!!" 1>&2
  exit 2
fi

if [ ! -d $HOME/bin ]
then
  echo "$progname: directory \"$HOME/bin\" does not exist or is not a directory" 
1>&2
  exit 2
fi

if [ ! -w $HOME/bin ]
then
  echo "$progname: directory \"$HOME/bin\" is not writable" 1>&2
  exit 2
fi

pathdirs=`echo $ORIGINAL_PATH | sed 's/:/ /g'`

found=false

for pathdir in $pathdirs
do
  if [ "$pathdir" == "$HOME/bin" ]
  then
    found=true
    break
  fi
done

if [ "$found" == "false" ]
then
  echo "$progname: directory $HOME/bin does not appear to be in $ORIGINAL_PATH" 1>&2
  exit 2
fi

cp -p menu.sh $HOME/bin/menu

chmod u=rwx,go=rx $HOME/bin/menu

echo
echo "menu command installed into $HOME/bin/menu"
echo
echo "if this the first install of \"menu\" then get started by creating"
echo "a file called $HOME/.00menu.conf with the following content:"
echo
echo "1: uptime"
echo "2: uname -a"
echo "3: ip address show | cat | more"
echo
echo "and then typing "menu" at the command prompt"
echo

exit 0
