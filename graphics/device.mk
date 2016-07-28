subdirs-true :=
subdirs-$(BOARD_USES_DRM_HWCOMPOSER) += drm
subdirs-$(CONFIG_GRALLOC_MALI) += gralloc
include $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/graphics/$(dir)/device.mk)
PRODUCT_COPY_FILES += $(PRODUCT_COPY_FILES-true)
