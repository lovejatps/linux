#!/bin/bash
##########################################
#
#	Arguments: eth0 ip gateway netmask dns1 dns2
#
##########################################
p='/etc/sysconfig/network-scripts/ifcfg-'
a='ifcfg-'
b=$a$1
mac=`ip addr | egrep 'link/ether\s+(.+)\s+brd.+$' | sed 's/^\s*//g' | sed 's/\s*$//g' | cut -d' ' -f2`
cp $p$1 $b
sed -i 's/^BOOTPROTO=.*$/BOOTPROTO="static"/' $b
sed -i 's/^HWADDR=.*//g' $b
sed -i 's/^MACADDR=.*//g' $b
sed -i 's/IPADDR.*//g' $b
sed -i 's/GATEWAY=.*//g' $b
sed -i 's/DNS1=.*//g' $b
sed -i 's/DNS2=.*//g' $b
echo 'HWADDR='$mac >> $b
echo 'MACADDR='$mac >> $b
echo 'IPADDR='$2 >> $b
echo 'GATEWAY='$3 >> $b
if [ $4!='' ]
then
        echo 'NETMASK='$4 >> $b
fi
if [ $5!='' ]
then
        echo 'DNS1='$5 >> $b
fi
if [ $6!='' ]
then
        echo 'DNS2='$6 >> $b
fi
cat $b
rm -f $p$1
cp -f $b $p$1
service network restart
