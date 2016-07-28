PRODUCT_PACKAGES += drm.rc

PRODUCT_PACKAGES += \
		libGLES_mesa \
		gralloc.drm

BOARD_SEPOLICY_DIRS += \
	device/linaro/generic/graphics/drm/sepolicy
