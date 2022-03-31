#!/bin/bash

echo ''
echo 'Bay Trail BIOS updater - Linux Version'
echo ''

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ -z "$1" ] || [ ! -f $1 ];then
  echo 'Programming guide :'
  echo 'Please enter the BIOS file parameter : ./updater.sh official_bios.xxx '
  echo ''
else 
  VER="$(./H2OFFTx64.sh $1 -sc | grep Version | tr -cd '[[:digit:]]')"
  if (( $(echo "$VER > 109" |bc -l) )); then
    echo
    ./H2OFFTx64.sh $1 -all -n
    ./H2OFFTx64.sh $1 -spn -n
  else
    echo
    systemd-inhibit --what=handle-suspend-key:sleep --why=updating --mode=block ./H2OFFTx64.sh $1 -all -n 2>/dev/null || printf "ERROR! Your system is not supported by Linux Baytrail BIOS updater!\nPlease use Windows or DOS Baytrail BIOS updater.\n"
    systemd-inhibit --what=handle-suspend-key:sleep --why=updating --mode=block ./H2OFFTx64.sh $1 -spn -n 2>/dev/null || printf "Contact SECO for further information\n\n"
  fi
fi

