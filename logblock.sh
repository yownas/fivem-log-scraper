#!/bin/sh

# "Patch" CitizenMP.Server.exe to block /log

if [ "$1" = "" ];then echo "Usage: $0 <filename of CitizenMP.Server.exe>";exit 1;fi
if [ \! -f "$1" ];then echo "Can not find file $1.";exit 1;fi

echo "Creating backup: ${1}.backup"
cp ${1} ${1}.backup || exit 1

MD5=`md5sum $1|cut -d' ' -f1` 
case "$MD5" in
  2d9848ca6b56ef72c65ccf84e8bf7f15)
    /usr/bin/printf '\x00' | dd conv=notrunc of=$1 bs=1 seek=$((0x00251f4d))
    echo "Done..."
    break
    ;;
  7f5f6df6fe5266a8c4ffa53a26ba2af0)
    /usr/bin/printf '\x00' | dd conv=notrunc of=$1 bs=1 seek=$((0x00363CD0))
    echo "Done..."
    break
    ;;
  *)
    echo "Unknown version. Exiting."
    exit
    ;;
esac

