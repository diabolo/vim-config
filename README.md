#   Vim Files

To use this configuration you need

1. Have a working ruby
1. Have vim installed with ruby support

Then you need to 

1. Back up existing vim files
1. Checkout this repository to ~/.vim
    
        git clone git@github.com:diabolo/vim-config.git .vim

1. Link .vimrc and .gvimrc to the vimrc and gvimrc files in this folder
1. Run `./update_bundles` in your .vim folder

## Credits

This config comes from [ Tammer Saleh ](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen)

# Usage

This configuration's purpose is to support programming Rails applications effectively. To do this it has some opinions about how things should be done. However its knowledge of Vim is very limited, and this config is very much work in progress. So if you think things should be done differently then fork it, make the changes and submit a pull request.

## File Navigation

Use Command-T to locate files, open files and open files that are already open (manage buffers). When working in a Rails project use the alternative file from rails.vim in addition to this `<:A>`

### Usage Example

- navigate to folder in command prompt
- open vim (do not pass in folder as parameter) 
    $ vim
- press ,t to activate command-t plugin

Immediately useful commands are:

 - `<Ctrl-c>`  - close command-T
 - `<Enter>`   - open selected file
 - type in text - restrict files in the list

Get help on plugin with `:help command-t`





