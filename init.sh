#!/vendor/bin/sh

get_max_cpus () {
	ls -1d /sys/devices/system/cpu/cpu[0-9]* | tail -n+2 | wc -l
}

setprop ro.maxcpu $(get_max_cpus)
