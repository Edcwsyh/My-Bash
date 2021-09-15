#!/bin/bash
# LinkCPPHead.sh [input] [output] [suffix_1] [suffix_2] ...
# 将[input]目录下的所有C++头文件以硬链接的方式在output目录下创建只读副本
#
# @param input : 必须是已存在的目录
# @param output : 可以是不存在的目录
# @param suffix : 后缀，默认为[h, hpp], 后缀之间用空格隔开
# version 0.1 : 拷贝h和hpp到指定目录

input=$1;
output=$2;

suffix_list=('h' 'hpp');

#if test $# -ge 4
#then
#    index=0;
#    while(( $index<$# ))
#    do
#        suffix_list[($index)]=${$index};
#        let "index++";
#    done
#fi

#/**
#* @description link_to_output 
#* @param path 需要执行建立硬链接的路径
#*/
function link_to_output() {
    dir=`ls $1`;
    for file in $dir;
    do
        if [ -f $1$file ];
        then
            for suffix in ${suffix_list[@]};
            do
                if [ "${file##*.}" == $suffix ]
                then
                    echo "Success : Create file : '$output$file'"
                    ln $1$file $output$file;
                fi
            done
        elif [ -d $1$file ];
        then
            link_to_output $1$file/;
        fi
    done
}

if [ ${input: -1} != '/' ];
then
    input=${input}/;
fi

if [ ${output: -1} != '/' ];
then
    output=${output}/;
fi

if [ ! -d $input ];
then
    echo "Error : The $input is not a directory or no exist!";
    exit;
fi

if [ ! -d $output ];
then 
    echo "Waning : Create path : '$output'";
    mkdir -p $output
fi

link_to_output $input;
