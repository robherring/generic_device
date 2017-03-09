#
# Copyright (C) 2014 The Android Open-Source Project
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

include $(LOCAL_PATH)/config.mk

include $(if $(CONFIG_TV), $(LOCAL_PATH)/device_tv.mk)
include $(if $(CONFIG_TABLET), $(LOCAL_PATH)/device_tablet.mk)

PRODUCT_NAME := $(TARGET_PRODUCT)
PRODUCT_DEVICE := $(TARGET_PRODUCT)
PRODUCT_BRAND := Android
PRODUCT_MODEL := AOSP

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES-$(CONFIG_KERNEL) += \
	$(call add-to-product-copy-files-if-exists,\
		$(CONFIG_KERNEL_PATH):kernel)

$(foreach dev,$(wildcard vendor/*/*/device-partial.mk), $(call inherit-product, $(dev)))

PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
			system/core/rootdir/init.rc:root/init.rc \
			$(LOCAL_PATH)/init.rc:root/init.unknown.rc \
			$(LOCAL_PATH)/ueventd.rc:root/ueventd.unknown.rc \
			$(LOCAL_PATH)/fstab:root/fstab.unknown)

PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
	$(LOCAL_PATH)/a300_pfp.fw:root/lib/firmware/a300_pfp.fw \
	$(LOCAL_PATH)/a300_pm4.fw:root/lib/firmware/a300_pm4.fw \
	$(LOCAL_PATH)/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq:root/lib/firmware/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq \
)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:system/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:system/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
    frameworks/native/data/etc/android.software.backup.xml:system/etc/permissions/android.software.backup.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    $(LOCAL_PATH)/media_codecs.xml:system/etc/media_codecs.xml \

PRODUCT_COPY_FILES-$(BOARD_HAVE_BLUETOOTH_LINUX) += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gadgets.rc:system/etc/init/gadgets.rc \
    $(LOCAL_PATH)/init.sh:system/bin/init.sh \

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=$(CONFIG_DALVIK_VM_HEAPSTARTSIZE)m \
    dalvik.vm.heapgrowthlimit=$(CONFIG_DALVIK_VM_HEAPGROWTHLIMIT)m \
    dalvik.vm.heapsize=$(CONFIG_DALVIK_VM_HEAPSIZE)m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=$(CONFIG_DALVIK_VM_HEAPMAXFREE)m

PRODUCT_PACKAGES-$(BOARD_HAVE_BLUETOOTH_LINUX) += \
	android.hardware.bluetooth@1.0-service \
	android.hardware.bluetooth@1.0-impl

subdirs-true := lights graphics
subdirs-$(CONFIG_WIFI) += wifi
subdirs-$(CONFIG_ETHERNET) += ethernet
subdirs-$(CONFIG_SENSOR) += sensor

include $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/$(dir)/device.mk)
DEVICE_PACKAGE_OVERLAYS += $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/$(dir)/overlay)

PRODUCT_COPY_FILES += $(PRODUCT_COPY_FILES-true)
PRODUCT_PROPERTY_OVERRIDES += $(PRODUCT_PROPERTY_OVERRIDES-true)
PRODUCT_PACKAGES += $(PRODUCT_PACKAGES-true)
