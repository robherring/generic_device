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

create_devices() {
	local device_dir="$(dirname "${BASH_SOURCE[0]}")"

	pushd ${device_dir} > /dev/null

	for f in configs/*_defconfig; do
		defconfig=$(basename "${f}")
		config_name=$(basename "${f}" _defconfig)
		command make O=${config_name} ${defconfig} all > /dev/null 2> /dev/null

		cat << EOF > ${config_name}/AndroidProducts.mk
PRODUCT_MAKEFILES := ${config_name}:\$(LOCAL_DIR)/../device.mk
EOF

		cat << EOF > ${config_name}/BoardConfig.mk
include ${device_dir}/${config_name}/config.mk
include ${device_dir}/BoardConfig.mk
EOF
		add_lunch_combo ${config_name}-userdebug
	done

	popd > /dev/null
}

create_devices
