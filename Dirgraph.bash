#!/bin/sh
export POSIXLY_CORRECT=yes
DIR=$(pwd)

#Checking arguments
if [ $# -eq 4 ]
    then
    FILE_ERE=$2
    DIR=$4
    histogram=1
    if [ ! -d "$4" ]
    then 
    echo "cannot find directory">&2
    exit 1
    fi
fi
#Checking arguments
if [ $# -eq 3 ] && [ "$1" = -i ] && [ "$3" != -n ] 
   then 
        if [ ! -d "$3" ]
        then
        echo "cannot find directory">&2
        exit 1
        fi
   DIR=$3   
fi      
#Checking arguments
if [ $# -eq 1 ] && [ "$1" != -n ] && [ "$1" != -i ]
   then 
        if [ ! -d "$1" ]
        then
        echo "cannot find directory">&2
        exit 1
        fi
   DIR=$1   
fi
#Checking arguments
if [ $# -gt 4 ]
    then
    echo "Too many arguments" >&2
    exit 2
fi
#Checking arguments
  while [ -n "$1" ]
     do
      if [ "$1" = -i ]
      then
          if [ -z "$2"  ]
            then
            echo "no arguments after -i">&2
            exit 3
          else
            FILE_ERE=$2
            files=1
          fi
      shift 2
      fi
      if [ "$1" = -n ]
          then 
          histogram=1
          shift
            if [ -n "$1" ] 
              then
              if [ ! -d "$1" ]
                then
                echo "cannot find directory">&2
                exit 
                fi
            fi
      fi
      if [ -d "$1" ]
        then 
        DIR=$1
        fi          
shift
done
#directory count in the directory tree
ND=$(du --exclude="$FILE_ERE" "$DIR" | wc -l)
if [ $ND -eq 0 ]
then 
echo "FILE_ERE mustn't cover name of root directory">&2
exit 5
fi
#number of all ordinary files
NF=$(find "$DIR" -type f ! -exec du --exclude="$FILE_ERE" -a {} + | wc -l)

sizer1=$(find "$DIR" -type f -size -100c ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer2=$(find "$DIR" -type f -size -1024c ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer3=$(find "$DIR" -type f -size -10k ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer4=$(find "$DIR" -type f -size -100k ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer5=$(find "$DIR" -type f -size -1024k ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer6=$(find "$DIR" -type f -size -10M ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer7=$(find "$DIR" -type f -size -100M ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer8=$(find "$DIR" -type f -size -1024M ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)
sizer9=$(find "$DIR" -type f -size +1G ! -exec du --exclude="$FILE_ERE" -a {} + 2>/dev/null| wc -l)

echo "Root directory: $DIR"
echo "Directories: $ND"
echo "All files: $NF"
echo "File size histogram:"

size01=$sizer1 
size12=$(( sizer2 -sizer1 ))
size23=$(( sizer3 -sizer2 ))
size34=$(( sizer4 -sizer3 ))
size45=$(( sizer5 -sizer4 ))
size56=$(( sizer6 -sizer5 ))
size67=$(( sizer7 -sizer6 ))
size78=$(( sizer8 -sizer7 ))
size89=$(( sizer9 -sizer8 ))

#if flag-n is set, normalization
if [ "$histogram" = "1" ]
then
 sirka=66
 #if the script is running in Terminal
    if [ -t 1 ]
    then
        sirka=$(($(tput cols) - 13))
        if [ "$size01" -gt "$sirka" ]
            then
            size01="$sirka"
        fi
        if [ "$size12" -gt "$sirka" ]
            then
            size12="$sirka"
        fi
        if [ "$size23" -gt "$sirka" ]
            then
            size23="$sirka"
        fi
        if [ "$size34" -gt "$sirka" ]
            then
            size34="$sirka"
        fi
        if [ "$size45" -gt "$sirka" ]
            then
            size45="$sirka"
        fi
        if [ "$size56" -gt "$sirka" ]
            then
            size56="$sirka"
        fi
        if [ "$size67" -gt "$sirka" ]
            then
            size67="$sirka"
        fi
        if [ "$size78" -gt "$sirka" ]
            then
            size78="$sirka"
        fi
        if [ "$size89" -gt "$sirka" ]
            then
            size89="$sirka"
        fi
     fi
        if [ "$size01" -gt "$sirka" ]
            then
            size01="$sirka"
        fi
        if [ "$size12" -gt "$sirka" ]
            then
            size12="$sirka"
        fi
        if [ "$size23" -gt "$sirka" ]
            then
            size23="$sirka"
        fi
        if [ "$size34" -gt "$sirka" ]
            then
            size34="$sirka"
        fi
        if [ "$size45" -gt "$sirka" ]
            then
            size45="$sirka"
        fi
        if [ "$size56" -gt "$sirka" ]
            then
            size56="$sirka"
        fi
        if [ "$size67" -gt "$sirka" ]
            then
            size67="$sirka"
        fi
        if [ "$size78" -gt "$sirka" ]
            then
            size78="$sirka"
        fi
        if [ "$size89" -gt "$sirka" ]
            then
            size89="$sirka"
        fi
fi
#grid listing
if [ $size01 -ge 0 ]
then
printf "  <100 B   : "
    i=0
    while [ $i -lt $size01 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <100 B   : "
fi
if [ $size12 -ge 0 ]
then
printf "  <1 KiB  : "
    i=0
    while [ $i -lt $size12 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <1 KiB  : "
fi
if [ $size23 -ge 0 ]
then
printf "  <10 KiB : "
    i=0
    while [ $i -lt $size23 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo " <10 KiB : "
fi
if [ $size34 -ge 0 ]
then
printf "  <100 KiB: "
    i=0
    while [ $i -lt $size34 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo " <100 KiB: "
fi
if [ $size45 -ge 0 ]
then
printf "  <1 MiB  : "
    i=0
    while [ $i -lt $size45 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <1 MiB  : "
fi
if [ $size56 -ge 0 ]
then
printf "  <10 MiB : "
    i=0
    while [ $i -lt $size56 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <10 MiB : "
fi
if [ $size67 -ge 0 ]
then
printf "  <100 MiB: "
    i=0
    while [ $i -lt $size67 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <100 MiB: "
fi
if [ $size78 -ge 0 ]
then
printf "  <1 GiB  : "
    i=0
    while [ $i -lt $size78 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  <1 GiB  : "
fi
if [ $size89 -ge 0 ]
then
    printf "  >=1 GiB  :"
    i=0
    while [ $i -lt $size89 ]
    do
    printf "#"
    i=$(( i + 1))
    done
    printf "\n"
else
echo "  >=1 GiB  : "
fi
