#!/bin/bash
#
# DESCRIPTION:
#   Script for static library generation.
#
# ATTENTION:
#   Due to the fact that script does not implement verification of specific
#   generated object files, while the script is running, there should not be
#   any files with .o extension in the folder.
#
# USAGE:
#   ./aGen.sh [output_library_name] {[cfiles_list]}

_c_res='\e[0m'
_c_red='\e[0;31m'
_c_green='\e[0;32m'
_c_yellow='\e[0;33m'
_c_blue='\e[0;34m'
_c_pur='\e[0;35m'

_def_indent=20

errorCheck() {
  if [[ $? != 0 ]]; then
    printf "\n\e[1;41;1m$1 has been failed. Exit..\e[m\n\n"
    exit 1
  fi
}

printTLine() {
  printf "%-${_def_indent}s $3%s$_c_res\n" "$1" "$2"
}

printBrief() {
  printf "$_c_yellow===============================================$_c_res\n\n"
  printf "Generating static library:\n\n"
  printTLine "Name of output file:" $1 $_c_yellow
  printTLine "Files list:" "$2" $_c_pur
  printf "\n"
  printf "$_c_yellow===============================================$_c_res\n\n"
}

file_index=2
files_list=${@:$file_index:$(expr $# - $file_index + 1)}

a_name="$1.a"

printBrief "$a_name" "$files_list"

gcc $files_list -Wall -c

errorCheck "Compilation"

ar -cvq $a_name *.c

errorCheck "Library compression"

printf "\n$_c_green%s$_c_res\n\n" ".a generation has been finished successfuly."
