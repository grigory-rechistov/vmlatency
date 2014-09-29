FNM=exp-`date +%s`.txt
echo "Experiment name: $FNM"

echo "Disabling frequency scaling"
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor;
do
    [ -f $CPUFREQ ] || continue;
    sudo sh -c "echo -n performance > $CPUFREQ;"
done

echo "Disabling all cores but the 0-th"

for CNO in `seq 1 64` # this is lame
do
    sudo sh -c "echo 0 > /sys/devices/system/cpu/cpu$CNO/online"
done

cat /proc/cpuinfo |head --lines 26 > $FNM
lsb_release -a >> $FNM

echo "Inserting/removing the kernel module"
sudo insmod ./vmlaunch_simple.ko
sleep 3 # why??
sudo rmmod vmlaunch_simple

echo ""
echo "Dmesg output" >> $FNM
echo ""
dmesg |tail --lines 120 >> $FNM

echo "Done"
