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

target() {
	local device_dir="$(dirname "${BASH_SOURCE[0]}")"

	pushd ${device_dir} > /dev/null

	case "$1" in
	menuconfig)
		command make menuconfig all
		;;
	reset)
		command make ${TARGET_PRODUCT}_defconfig all
		;;
	save)
		command make savedefconfig
		cp ${TARGET_PRODUCT}/defconfig configs/${TARGET_PRODUCT}_defconfig
		;;
	*)
		printf "Missing/invalid command:\n\n"
		printf "menuconfig - Configure the target running menuconfig\n"
		printf "reset - Reset the target to the defconfig\n"
		printf "save - Save the current configuration to the defconfig\n"
		;;
	esac

	popd > /dev/null
}

create_devices() {
	local device_dir="$(dirname "${BASH_SOURCE[0]}")"

	pushd ${device_dir} > /dev/null

	for f in configs/*_defconfig; do
		local defconfig=$(basename "${f}")
		local config_name=$(basename "${f}" _defconfig)

		# Use the existing .config if it exists
		if [ -f "${config_name}/.config" ]; then
			defconfig="olddefconfig"
		fi
		command make O=${config_name} ${defconfig} all > /dev/null 2> /dev/null

		local prod_dev=$(sed -n -e 's/CONFIG_PRODUCT_DEVICE=\(.*\)/\1/p' ${config_name}/config.mk)
		if [ -z "${prod_dev}" ]; then
			local prod_dev=linaro_$(sed -n -e 's/TARGET_ARCH=\(.*\)/\1/p' ${config_name}/config.mk)
		fi

		cat << EOF > ${config_name}/AndroidProducts.mk
PRODUCT_MAKEFILES := ${config_name}:\$(LOCAL_DIR)/device.mk
EOF

		cat << EOF > ${config_name}/device.mk
include \$(LOCAL_PATH)/config.mk

\$(call inherit-product, \$(LOCAL_PATH)/../device.mk)

PRODUCT_DEVICE := ${prod_dev}
EOF

		mkdir -p ${prod_dev}
		cat << EOF > ${prod_dev}/BoardConfig.mk
include ${device_dir}/\$(TARGET_PRODUCT)/config.mk
include ${device_dir}/BoardConfig.mk
EOF
		add_lunch_combo ${config_name}-userdebug
	done

	popd > /dev/null
}

create_devices
