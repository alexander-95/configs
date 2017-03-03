#!/bin/bash
function link
{
    ln .emacs ~/.emacs
    ln .bashrc ~/.bashrc
    ln .tmux.conf ~/.tmux.conf
}

function jre
{
    jre="http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jre-8u111-linux-x64.tar.gz"
    cookie="Cookie: oraclelicense=accept-securebackup-cookie"
    tarball="jre-8u111-linux-x64.tar.gz"
    wget --no-check-certificate --no-cookies --header "$cookie" wget $jre
    sudo mkdir /usr/local/java
    sudo cp -r $tarball /usr/local/java/
    cd /usr/local/java
    sudo tar xvzf $tarball
    sudo rm $tarball
    jre=$(ls)
    sudo echo "JRE_HOME=/usr/local/java/$jre" >> /etc/profile
    sudo echo "PATH=$PATH:$JRE_HOME/bin" >> /etc/profile
    sudo echo "export JRE_HOME" >> /etc/profile
    sudo echo "export PATH" >> /etc/profile
    sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/$jre/bin/java" 1
    sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/$jre/bin/javaws" 1
    sudo update-alternatives --set java /usr/local/java/$jre/bin/java
    sudo update-alternatives --set javaws /usr/local/java/$jre/bin/javaws
    . /etc/profile
}

function colorscheme
{
    gsettings set org.pantheon.terminal.settings palette "#75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2AA198:#f9f8f5:#272822:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2AA198:#f8f8f2"
    gsettings set org.pantheon.terminal.settings foreground "#94a3a5"
    gsettings set org.pantheon.terminal.settings background "rgba(0,0,0,0.85)"
    gsettings set org.pantheon.terminal.settings cursor-color "#839496"
    #gsettings set org.pantheon.terminal.settings follow-last-tab "true"
}

link


#palette #75715e:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2AA198:#f9f8f5:#272822:#f92672:#a6e22e:#f4bf75:#66d9ef:#ae81ff:#2AA198:#f8f8f2
#cursor-color #839496
#background rgba(0, 0, 0, 0.85)
#foreground #94a3a5
