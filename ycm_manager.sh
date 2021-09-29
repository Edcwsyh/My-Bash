#!/bin/bash
# ycm_manger.sh [option]
# YouCompleteMe管理器
#
# Create time : 2021-09-27
# version 0.1 -- 2021-09-27 : install与update功能(安装与更新)

input=$1;

local_repo=~/.vim/bundle/YouCompleteMe
remote_repo=https://gitee.com/edcwsyh/YouCompleteMe.git
build_path=/tmp/$USER/YouCompleteMe.build

function install() {
    echo -e "\e[1;32mBegin\e[0m : Start the installation of 'YouCompleteMe'!";
    if [ ! -d $local_repo ]
    then
        mkdir -p $local_repo
    fi
    git clone $remote_repo $local_repo
    #判断.git目录是否存在，否则表示克隆失败
    if [ -d $local_repo/.git ]
    then
        if [ ! -d $build_path ]
        then
            mkdir -p $build_path
        fi
        echo -e "\e[1;32mSuccess\e[0m : clone repository complete!";
        git --git-dir=$local_repo/.git submodule update --init --recursive
        python3 $local_repo/install.py --all --build-dir=$build_path
        #删除构建目录
        rm -rf $build_path/*
    else
        echo -e "\e[1;31mError\e[0m : clone repository fail!";
    fi
}

function update() {
    echo -e "\e[1;32mBegin\e[0m : Start updating 'YouCompleteMe'!";
    if [ -d $local_repo ]
    then
        git --git-dir=$local_repo/.git pull
        git --git-dir=$local_repo/.git submodule update --init --recursive
        if [ ! -d $build_path ]
        then
            mkdir -p $build_path
        fi
        python3 $local_repo/install.py --all --build-dir=$build_path
        #删除构建目录
        rm -r $build_path/*
    else
        echo -e "\e[1;31mError\e[0m : No local repository exists,  please run 'ycm_manger --install'";
    fi
}

case "$input" in
    "--update")
        update;;
    "-u")
        update;;
    "--install")
        install;;
    "-i")
        install;;
    "--help")
        echo "Usag ycm_menger --insatll/--update";;
    "--h")
        echo "Usag ycm_menger --insatll/--update";;
    *)
        echo "Usag ycm_menger --help/-h";;
esac
