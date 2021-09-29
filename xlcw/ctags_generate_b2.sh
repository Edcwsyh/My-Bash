#!/bin/bash
#生成best2项目的tags文件
param="-R --languages=c++ --c++-kinds=+px --fields=+aiKSz --extra=+q"
output_dir=~/.cache/tags
input_dir=~/local_develop/china_develop

protocol_output_dir=$output_dir/.proto_tags;
base_output_dir=$output_dir/.base_tags;
dep_output_dir=$output_dir/.dep_tags;

zone_output_dir=$input_dir/src/zone/.tags;
online_output_dir=$input_dir/src/online/.tags;
unionsvr_output_dir=$input_dir/src/unionsvr/.tags;
function generate() {
    echo -e "\e[1;32mBegin\e[0m : Start generating files";
    if [ ! -d $output_dir ]
    then
        echo -e "\e[1;32mWarning\e[0m : The dir directory does not exist and is automatically created";
        mkdir -p $output_dir;
    fi
    cd $input_dir/protocol; ctags $param -f $protocol_output_dir;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $protocol_output_dir";
    cd $input_dir/src/base; ctags $param -f $base_output_dir;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $base_output_dir";
    cd $input_dir/dep; ctags $param -f $dep_output_dir;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $dep_output_dir";

    cd $input_dir/src/zone; ctags $param -f .tags;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $zone_output_dir";
    cd $input_dir/src/online; ctags $param -f .tags;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $online_output_dir";
    cd $input_dir/src/unionsvr; ctags $param -f .tags;
    echo -e "\e[1;32mComplete\e[0m : Generate file : $unionsvr_output_dir";
}

function clean() {
    rm -rf $output_dir/.proto_tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $protocol_output_dir";
    rm -rf $output_dir/.base_tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $base_output_dir";
    rm -rf $output_dir/.dep_tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $dep_output_dir";

    rm -rf $input_dir/src/zone/.tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $zone_output_dir";
    rm -rf $input_dir/src/online/.tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $online_output_dir";
    rm -rf $input_dir/src/unionsvr/.tags;
    echo -e "\e[1;32mComplete\e[0m : Remove file : $unionsvr_output_dir";
}

input=$1;
case "$input" in
    "--generate")
        generate;;
    "-g")
        generate;;
    "--clean")
        clean;;
    "-c")
        clean;;
    "--help")
        echo "Usag ctags_generate_b2 --generate/--clean";;
    "-h")
        echo "Usag ctags_generate_b2 --generate/--clean";;
    *)
        echo "Usag ctags_generate_b2 --help/-h";;
esac
