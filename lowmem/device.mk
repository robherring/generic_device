PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true \
	dalvik.vm.jit.codecachesize=0 \

PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/lowmem.rc:$(TARGET_OUT_VENDOR)/etc/init/lowmem.rc
