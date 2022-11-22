# My Dotfiles

These are my dotfile configuration files for different software in Bash.

## bin Directory

This contains the scripts that the Makefile will run via its targets.

## etc Directory

This contains my editable text configuration files that the makefile will
add to the user's home directory so that they may be used by programs as the
default configuration for that specific user.

## Makefile

Uses the scripts in the bin directory to add the contents of config files
in the etc directory to their respective config files in the user's 
home directory.


## etc/vimrc

Custom vim config. It turns on syntax highlighting, adds a line number
column, turn on autoindentation, turns on the ruler function, sets the 
colorscheme to the ElfLord colorscheme which is provided by default by Vim,
and sets an autoconfiguration specific to makefiles that essentially makes
sure that tabs in makefiles are true tabs '\\t' tabs and not just spaces.

## etc/bashrc_custom

This will be added to the existing bashrc using a source cmd in the
linux.sh script. This adds some custom functionalities to our current 
bashrc, via aliases and functions. lsl will list all files in the specified
directory along with some metadata in a single-column vertical list, lsa
will list all files including hidden (dot) files, lsal is a combination of
the two, which will list all files in a single vertical column, but also
includes hidden (dot) files, it also adds a trash alias which basically 
moves stuff we want to delete to a trash directory, .TRASH, and we remove 
the contents of the trash directory with another alias, rmtrash. There is
also an alias for remoting into the Linux Lab at UofSC, via ssh. Addition-
ally there are two aliases for creating and extracting gzipped tarballs, 
aliased, targz and untar, which both work via functions that 
take a file name as a parameter and then they use the tar command to 
make or extract the parameterized archive.

## bin/linux.sh

Will only run on the Linux Operating System. This script will back-up
the current .vimrc in the home directory, if it exists, by re-
naming it to .bup_vimrc. It then copies the contents of the etc/vimrc to
.vimrc in the home directory; this overwrites .vimrc, hence why the backup
file was made. Then it lastly, it appends the line, 'source ~/.dotfiles/etc/
custom_bashrc' to the end of, either a pre-existing or new, .bashrc file 
in the home directory.

## bin/cleanup.sh

This will just clean up the config file adjustments we made from our 
linux.sh script. It deletes the newly-created .vimrc file, and if it exists,
will rename .bup_vimrc to .vimrc, and then, using sed, it  removes that last
line appended to .bashrc, 
'source ~/.dotfiles/etc/custom_bashrc', with a blank line. 
Finally it removes the .TRASH directory.
