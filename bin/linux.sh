#!/bin/bash

# Store output of uname (which gets OS name) in variable called OS
OS=$(uname)

# Check if $OS var is a string that says, "Linux"
if [[ $OS != "Linux" ]] ; then
	# Redirect this echo to stderr and then append it to linuxsetup.log
	>&2 echo "Error: OS is not Linux" >> linuxsetup.log
	# Exit the script
	exit
# Else OS must be Linux
else
	# Make trash directory for our makeshift recycle bin
	mkdir -p ~/.TRASH
	# If .vimrc already exists in home dir then...
	if [ -f ~/.vimrc ] ; then
		# Rename .vimrc to .bup_vimrc (bup short for backup)
		mv ~/.vimrc ~/.bup_vimrc
		# Log that the current .vimrc was renamed for backing up.
		echo "Current .vimrc file was changed to .bup_vimrc" >> linuxsetup.log
	# End of if statement
	fi
	# Print contents of our .dotfiles directory's etc/.vimrc to home directory's .vimrc
	cat ./etc/vimrc > ~/.vimrc
	# Append this shell script command to the end of the bashrc in home dir
	echo "source ~/.dotfiles/etc/bashrc_custom" >> ~/.bashrc
# End of outer if statement
fi




