#!/bin/bash

help() {
    # display help
   echo "Simulate the path_planning algorithm"
   echo
   echo "Usage: ./c_simulator.sh -h, -f <file_path> -s <start_point> -e <end_point>"
   echo "options:"
   echo "h     Print this Help."
   echo "f     Path of the t1b_path_planner.c file."
   echo "s     Start point."
   echo "e     End point."
   echo
}

if [ "$#" -eq 6 ]; then
    while getopts "hf:s:e:" opt; do
        case "$opt" in
            f) file_path=$OPTARG ;;
            s) start_point=$OPTARG ;;
            e) end_point=$OPTARG ;;
            h) help ;;
            :) echo "argument missing for $ARG" ;;
            \?) echo "Something is wrong" ;;
        esac
    done
else
    help
    exit 1
fi

echo; echo "================================"
echo; echo "          C Simulator           ";
echo; echo "--------------------------------"; echo

echo "Executing file: $file_path"

echo; echo "================================"; echo

if [ ! -f "$file_path" ]; then
    echo "File $file_path does not exist."
    exit 1
fi

gcc "$file_path" -o output_file
if [ $? -ne 0 ]; then
    echo; echo "Compilation failed, kindly check for errors."
    exit 1
fi

./output_file "$start_point" "$end_point"
rm -f output_file
