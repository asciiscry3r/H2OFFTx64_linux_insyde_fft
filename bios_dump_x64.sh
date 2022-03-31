#!/bin/bash

echo ''
echo 'Bay Trail BIOS dumper - Linux Version'
echo ''


if [ -z "$1" ];then
	echo 'Please enter the BIOS name parameter : ./bios_dump.sh bios_name.xxx '
	echo ''
else 
	./H2OFFTx64.sh $1 -g
fi

