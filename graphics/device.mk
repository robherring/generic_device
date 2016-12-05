PRODUCT_PROPERTY_OVERRIDES-$(CONFIG_SW_GRAPHICS) += ro.kernel.qemu=1

PRODUCT_PACKAGES-true += libGLES_android

subdirs-true :=
subdirs-$(BOARD_USES_DRM_HWCOMPOSER) += drm
subdirs-$(CONFIG_GRALLOC_MALI) += gralloc
include $(foreach dir,$(subdirs-true), $(LOCAL_PATH)/graphics/$(dir)/device.mk)
