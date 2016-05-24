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

include $(dir $(lastword $(MAKEFILE_LIST)))/config.mk

BOARD_USES_DRM_HWCOMPOSER := true
BOARD_GPU_DRIVERS := freedreno virgl

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := $(CONFIG_SYSTEMIMAGE_FS_TYPE)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := $(CONFIG_SYSTEMIMAGE_SIZE)
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := $(CONFIG_DISABLE_SPARSE_USERIMAGES)

TARGET_NO_KERNEL := $(if $(CONFIG_KERNEL),,true)

WITH_DEXPREOPT := $(CONFIG_DEX_PREOPT)
#$(info $(TARGET_USERIMAGES_SPARSE_EXT_DISABLED))
#$(error $(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE))
