#
# ~/.bashrc
#


# hard folder
#if [ -d ~/.bash_stuff ]; then                                                         
[[ -d ~/.bash_stuff ]] && 
    for file in $(find ~/.bash_stuff -maxdepth 1 -type f -name "*.bash" -o -name "*.bash_priv"); do
        . ${file}
    done

# symbolic link 
[[ -h ~/.bash_stuff ]] && 
    for file in $(find -L ~/.bash_stuff -maxdepth 1 -type f -name "*.bash" -o -name "*.bash_priv"); do
        . ${file}
    done

# user specified goodies
[[ -f ~/.bash_user ]] && . ~/.bash_user

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


