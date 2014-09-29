FNM=exp-`date +%s`
cat /proc/cpuinfo |head --lines 26 > $FNM
lsb_release -a >> $FNM
sudo insmod ./vmlaunch_simple.ko ; sudo rmmod vmlaunch_simple
dmesg |tail --lines 31 >> $FNM
