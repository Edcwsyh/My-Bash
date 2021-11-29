#!/bin/bash
# ycm_manger.sh [option]
# YouCompleteMe管理器
#
# Create time : 2021-09-27
# version 0.1 -- 2021-09-27 : install与update功能(安装与更新)

input=$1;

#本地仓库目录
local_repo=~/.vim/plugged/YouCompleteMe
#远程仓库目录
remote_repo=https://github.com/ycm-core/YouCompleteMe.git
#临时构建目录
build_path=/tmp/$USER/YouCompleteMe.build
#构建模式
build_mod=--clangd-completer

function install() {
    echo -e "\e[1;32mBegin\e[0m : Start the installation of 'YouCompleteMe'!";
    if [ ! -d $local_repo ]
    then
        mkdir -p $local_repo
    fi
    if [ ! -d $local_repo/.git ]
    then
        git clone $remote_repo $local_repo
        if [ ! -d $local_repo/.git ]
        then
            echo -e "\e[1;31mError\e[0m : clone repository fail!";
            return;
        fi
    else
        is_reinput=1;
        while [ $is_reinput == 1 ];
        do
            is_reinput=0;
            echo -e "\e[1;33mWarning\e[0m : YouCompleteMe already existed! need rebuild?(Y/N):\c"; 
            read is_rebuild;
            case "$is_rebuild" in
                "Y") ;; "y") ;; "yes") ;; "Yes") ;;
                "N") return;;"n") return;;"no") return;;"No") return;;
                *)
                    echo -e "\e[1;31mError\e[0m : Please input yes or no !";
                    is_reinput=1;
        esac
        done;

    fi
    #判断.git目录是否存在，否则表示克隆失败
    if [ ! -d $build_path ]
    then
        mkdir -p $build_path
    fi
    echo -e "\e[1;32mSuccess\e[0m : clone repository complete!";
    cd $local_repo;
    git submodule update --init --recursive
    python3 $local_repo/install.py $build_mode --build-dir=$build_path
    #删除构建目录
    rm -rf $build_path/*
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
        python3 $local_repo/install.py $build_mode --build-dir=$build_path
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
    "-h")
        echo "Usag ycm_menger --insatll/--update";;
    *)
        echo "Usag ycm_menger --help/-h";;
esac
