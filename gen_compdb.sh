#!/bin/bash

project_root=$1
compdb_dir_name=.compdb_build

cd $project_root
mkdir $compdb_dir_name
cd $compdb_dir_name
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 

echo -e "\e[1;32mSuccess\e[0m : Start compdb";
compdb -p . list > ./compile_commands.json.out
mv ./compile_commands.json.out ../compile_commands.json
cd ..
rm -rf ./$compdb_dir_name
