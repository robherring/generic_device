
$(foreach dev,$(wildcard vendor/*/*/device-partial.mk), $(call inherit-product, $(dev)))

comma := ,

ifeq ($(CONFIG_FIRMWARE_ALL),true)
fw_files := $(shell git -C external/linux-firmware ls-files | grep -v -E '(WHENCE|LICEN|NOTICE|README)')
else
fw_files := $(subst $(comma), ,$(CONFIG_FIRMWARE_FILES))
endif

PRODUCT_COPY_FILES := $(join \
	$(patsubst %,external/linux-firmware/%, $(fw_files)), \
	$(patsubst %,:$(TARGET_COPY_OUT_VENDOR)/firmware/%, $(fw_files)))
