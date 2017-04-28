#lowmem items
PRODUCT_PACKAGES := \
		lowmem.rc \

PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.low_ram=true \
	dalvik.vm.jit.codecachesize=0 \

