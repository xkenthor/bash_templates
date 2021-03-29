#!/bin/bash
#
# Script for shared object (shared library) generation.
#
# ATTENTION:
#   Due to the fact that script does not implement verification of specific
#   generated object files, while the script is running, there should not be
#   any files with .o extension in the folder.
#
# USAGE:
#   ./genSo.sh [output_library_name] [major_ver] [minor_ver] {[cfiles_list]}

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
  printf "Generating shared object library:\n\n"
  printTLine "Name of output file:" $2 $_c_yellow
  printTLine "Library -soname:" $1 $_c_yellow
  printTLine "Version:" "$3" $_c_yellow
  printf "\n"
  printTLine "Files list:" "$4" $_c_pur
  printf "\n"
  printf "$_c_yellow===============================================$_c_res\n\n"
}

file_index=4
so_name="lib$1"
so_maj_ver=$2
so_min_ver=$3

files_list=${@:$file_index:$(expr $# - $file_index + 1)}

so_soname="$so_name.so" #.$so_maj_ver"
so_filename="$so_soname.$so_min_ver"

printBrief $so_soname $so_filename $so_maj_ver.$so_min_ver "$files_list"

# generating object files of c code
gcc $files_list -Wall -fPIC -c

errorCheck "Compilation"

gcc *.o -Wall -shared -Wl,-soname,$so_soname -o $so_filename

errorCheck "Library generation"

printf "$_c_green%s$_c_res\n\n" ".so generation has been finished successfuly."
