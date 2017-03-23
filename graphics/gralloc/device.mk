subdirs-true :=
subdirs-true += mali
$(call inherit-product-dirs, $(subdirs-true))

#include $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/graphics/gralloc/$(dir)/device.mk)
