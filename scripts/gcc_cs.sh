#!/bin/bash
#
# DESCRIPTION
#  gcc compilation & execution script for fast debugging.
#
# USAGE:
#   ./gcc_cs.sh [input_cfile_name] [output_cfile_name]

errorCheck() {
  if [[ $? != 0 ]]; then
    printf "\n\e[1;41;1m$1 has been failed. Exit..\e[m\n\n"
    exit 1
  fi
}

source_name=$1

dsize=$(expr ${#source_name} - 2)
destination_name="${source_name:0:dsize}.o"

errorCheck "Name generation"

gcc $source_name -Wall -o $destination_name

errorCheck "Compilation"

exec_name="./$destination_name"
printf "\n\nExecution \e[0;49;93m$destination_name: \e[m\n"
printf "\e[0;49;93m===\e[m\n\n"

$exec_name

errorCheck "Execution"
printf "\e[0;49;93m\n===\e[m\n"
