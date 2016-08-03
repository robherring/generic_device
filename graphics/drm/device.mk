PRODUCT_PACKAGES += drm.rc

PRODUCT_PACKAGES += \
		libGLES_mesa \
		hwcomposer.drm \
		gralloc.drm

BOARD_SEPOLICY_DIRS += \
	device/linaro/generic/graphics/drm/sepolicy
