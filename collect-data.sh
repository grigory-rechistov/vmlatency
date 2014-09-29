FNM=exp-`date +%s`.txt
echo "Experiment name: $FNM"

echo "Disabling frequency scaling"
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
do
    [ -f $CPUFREQ ] || continue;
    echo -n performance > $CPUFREQ;
done

cat /proc/cpuinfo |head --lines 26 > $FNM
lsb_release -a >> $FNM

echo "Inserting/removing the kernel module"
sudo insmod ./vmlaunch_simple.ko ; sudo rmmod vmlaunch_simple
dmesg |tail --lines 31 >> $FNM

echo "Done"
