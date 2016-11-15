subdirs-true :=
subdirs-true += mali
include $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/graphics/gralloc/$(dir)/device.mk)
