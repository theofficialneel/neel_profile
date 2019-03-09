#!/bin/zsh
function linkfile() {
    local SOURCE=$1
    local DEST=$2
    local SUDO=$3
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    if (( $SUDO ))
    then
        [ -f $DEST -o -L $DEST ] && sudo rm $DEST
        [ -d $DEST ] && sudo rmdir $DEST
        sudo ln -s $DIR/$SOURCE $DEST
    else
        [ -f $DEST -o -L $DEST ] && rm $DEST
        [ -d $DEST ] && rmdir $DEST
        ln -s $DIR/$SOURCE $DEST
    fi
}

# linkfile git/.gitconfig             ~/.gitconfig                            0

#Not linking vscode - syncing through the sync plugin
# linkfile vscode/snippets            ~/.config/Code/User/snippets            0
# linkfile vscode/keybindings.json    ~/.config/Code/User/keybindings.json    0
# linkfile vscode/settings.json       ~/.config/Code/User/settings.json       0


#linkfile emacs/init.el              ~/.emacs                                0
#linkfile remmina                    ~/.remmina                              0
#linkfile luckybackup/MyBackup.profile  ~/.luckyBackup/profiles/MyBackup.profile 0

#linkfile resolvconf-ubuntu/head            /etc/resolvconf/resolv.conf.d/head  1
#linkfile resolvconf-ubuntu/tail            /etc/resolvconf/resolv.conf.d/tail  1
#sudo resolvconf -u;
