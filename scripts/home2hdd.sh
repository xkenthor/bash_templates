#!/bin/bash
source_directory="/home/username"
dest_directory="/media/volume"
folder_list=(Documents Music Downloads Pictures Videos Public)

for folder in ${folder_list[@]};
do
    source_path=$source_directory$folder
    dest_path=$dest_directory$folder

    if [[ -d $source_path ]]; then

        if [[ ! -L $source_path ]]; then

            if [[ -d $dest_path ]]; then
                mv -f $source_path/* $dest_path
                rm -rf $source_path
            else
                mv $source_path $dest_directory
            fi

        else
            rm $source_path
        fi

    fi

    if [[ ! -d $dest_path ]]; then
        mkdir $dest_path
    fi

    ln -sf $dest_path $source_path

done
