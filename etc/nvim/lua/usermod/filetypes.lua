local groups =
{
    {
        pattern = {'*.cc', '*.cpp', '*.cxx', '*.hpp', '*.c', '*.h'},
        command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2',
    },
    {
        pattern = { '*.mk', '?akefile', 'make' },
        command = 'setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab',
    },
    {
        pattern = '*.zshsrc',
        command = 'setlocal syntax=zsh',
    },
    {
        pattern = { '*.shsrc', '*.bashsrc' },
        command = 'setlocal syntax=bash',
    },
    {
        pattern = '*.xcolor',
        command = 'setlocal syntax=xdefault',
    }
}
return groups
