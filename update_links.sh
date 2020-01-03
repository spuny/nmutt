#!/bin/bash

#----------------------------------------------------------------------------------
# Project Name      - VimConfig/update_links.sh
# Started On        - Sun 22 Oct 00:15:02 BST 2017
# Last Change       - Thu  9 May 13:56:22 BST 2019
# Author E-Mail     - terminalforlife@yahoo.com
# Author GitHub     - https://github.com/terminalforlife
#----------------------------------------------------------------------------------
# Just a simple, quick script to update the hard links when changing branches.
#----------------------------------------------------------------------------------

XERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; exit 1; }
ERR(){ printf "[L%0.4d] ERROR: %s\n" "$1" "$2" 1>&2; }

declare -i DEPCOUNT=0
for DEP in /bin/{ln,rm}; {
	if ! [ -x "$DEP" ]; then
		ERR "$LINENO" "Dependency '$DEP' not met."
		DEPCOUNT+=1
	fi
}

[ $DEPCOUNT -eq 0 ] || exit 1

if ! [ "${PWD//*\/}" == "nmutt" ]; then
	XERR "$LINENO" "Not in the repository's root directory."
fi

if [ ! -f $HOME/.config/mutt_pass/password.gpg" ];
then
    echo "Create password file in ~/.config/mutt_pass/password.gpg"
    echo " Please encrypt it!!!"
    exit 1
fi

/bin/rm -v $HOME/.config/neomuttrc 2>&-
/bin/ln -v .neomuttrc $HOME/.config/neomutrc 2>&-

/bin/rm -v $HOME/.neomuttrc 2>&-
/bin/ln -v .neomutrc $HOME/.neomuttrc 2>&-

# vim: noexpandtab colorcolumn=84 tabstop=8 noswapfile nobackup
