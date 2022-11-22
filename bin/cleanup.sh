#!/bin/bash

# Removes the created .vimrc file
rm -f ~/.vimrc

# If there was a backup beforehand, then rename it to .vimrc
if [ -f ~/.bup_vimrc ] ; then
	# Let user know this happened
	echo ".bup_vimrc file found. Renaming the file to .vimrc to"
	echo "restore it to the way it was before the the makefile."
	# Rename using mv command
	mv ~/.bup_vimrc ~/.vimrc
fi

# Remove the command that sourced our custom bashrc via sed command
sed -i 's+source ~/.dotfiles/etc/bashrc_custom++g' ~/.bashrc

# Remove the directory .TRASH using the rm command and the recursive flag.
rm -rf ~/.TRASH


