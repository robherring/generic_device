#
# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file is executed by build/envsetup.sh, and can use anything
# defined in envsetup.sh.
#
# In particular, you can add lunch options with the add_lunch_combo
# function: add_lunch_combo generic-eng

# Note: all variables must be local or they get sourced.

gen_arm64_only() {
	echo 'TARGET_ARCH := arm64'
	echo 'TARGET_ARCH_VARIANT := armv8-a'
	echo 'TARGET_CPU_VARIANT := generic'
	echo 'TARGET_CPU_ABI := arm64-v8a'

	echo 'TARGET_USES_64_BIT_BINDER := true'
}

gen_arm64() {
	gen_arm64_only

	echo 'TARGET_2ND_ARCH := arm'
	echo 'TARGET_2ND_ARCH_VARIANT := armv7-a-neon'
	echo 'TARGET_2ND_CPU_VARIANT := cortex-a15'
	echo 'TARGET_2ND_CPU_ABI := armeabi-v7a'
	echo 'TARGET_2ND_CPU_ABI2 := armeabi'
}

gen_arm() {
	echo 'TARGET_ARCH := arm'
	echo 'TARGET_ARCH_VARIANT := armv7-a'
	echo 'TARGET_CPU_VARIANT := generic'
	echo 'TARGET_CPU_ABI := armeabi-v7a'
	echo 'TARGET_CPU_ABI2 := armeabi'
}

gen_x86_64_only() {
	echo 'TARGET_ARCH := x86_64'
	echo 'TARGET_ARCH_VARIANT := x86_64'
	echo 'TARGET_CPU_ABI := x86_64'

	echo 'TARGET_USES_64_BIT_BINDER := true'
}

gen_x86_64() {
	gen_x86_64_only

	echo 'TARGET_2ND_ARCH := x86'
	echo 'TARGET_2ND_ARCH_VARIANT := x86_64'
	echo 'TARGET_2ND_CPU_ABI := x86'
}

gen_device() {
	local config_base="linaro"
	local config_name="${config_base}_$1"
	local device_dir="$(dirname "${BASH_SOURCE[0]}")"
	local device_mk="device"

	case "$1" in
	*64)
		local device_mk="device_64"
		;;
	*64_only)
		local device_mk="device_64only"
		;;
	*)
		local device_mk="device"
		;;
	esac

	mkdir -p "${device_dir}/${config_name}"

	cat << EOF > ${device_dir}/${config_name}/AndroidProducts.mk
PRODUCT_MAKEFILES := ${config_name}:\$(LOCAL_DIR)/../${device_mk}.mk
EOF

	gen_${1} > ${device_dir}/${config_name}/BoardConfig.mk
	echo "include ${device_dir}/BoardConfig.mk" >> ${device_dir}/${config_name}/BoardConfig.mk

	add_lunch_combo ${config_name}-userdebug

}

create_devices() {
	local a
	local arches="arm arm64 x86_64"
	for a in $arches; do
		gen_device $a
		if $(echo $a | grep -q "64"); then
			gen_device ${a}_only
		fi
	done
}
create_devices
