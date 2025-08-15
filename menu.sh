#!/bin/bash
#
# @(!--#) @(#) menu.sh, sversion 0.1.0, fversion 009, 15-august-2025
#
# display a simple menu based on a .00menu.conf file being readable
#

set -u

#
# Main
#

# set the name of the script
progname=`basename $0`

# set the menufile, hidden with a leading . (dot)
menufile=".00menu.conf"

# search for the menufile
if [ -r example$menufile ]
then
  MENUFILE=example$menufile
elif [ -r $menufile ]
then
  MENUFILE=$menufile
elif [ -r $HOME/$menufile ]
then
  MENUFILE=$HOME/$menufile
else
  echo "$progname: no menu file \"$menufile\" found in current directory or $HOME" 1>&2
  exit 1
fi

# main loop
while true
do
  # display the menu
  echo
  cat $MENUFILE | grep -v '^#' | grep -v '^$'
  echo
  echo -n "Option ('q' to quit): "

  # get menu option from the user
  read option

  # it is "q" then quit gracefully
  if [ "$option" == "q" ]
  then
    break
  fi

  # if the option is not the null string
  if [ "$option" != "" ]
  then
    # examine the option
    case "$option" in
      # looks like an option number
      [1-9]*)
        cmd=`cat $MENUFILE | grep "^${option}: " | cut -d: -f2-`
        if [ "$cmd" == "" ]
        then
          echo "Invalid option."
        else
          # echo "CMD: \"$cmd\""
          eval $cmd
        fi
        ;;
      # anything else is likely a bad choice
      *)
        echo "Invalid option"
        ;;
    esac
  fi
done

# quit gracefully as option was 'q' to quit
exit 0

# end of file: menu.sh
