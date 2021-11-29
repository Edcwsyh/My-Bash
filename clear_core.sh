#!/bin/bash
# clear_core.sh [path]
# 清理[path]下的所有core调试文件
# path : 项目根目录
#
# Create time : 2021-11-29

PROJECT_ROOT=$1;

PROJECT_RUN=$PROJECT_ROOT/run

RUN_LIST=`ls $PROJECT_RUN`

for file in $RUN_LIST
do
    if [ -d $PROJECT_RUN/$file/bin ]
    then
        core_list=`find $PROJECT_RUN/$file/bin -name "*.core" `;
        for core_file in $core_list
        do
            echo $core_file;
        done
        echo -e "\e[1;32mSuccess\e[0m : Clear $PROJECT_RUN/$file complete!";
    fi
done
