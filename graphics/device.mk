PRODUCT_PROPERTY_OVERRIDES := $(if $(CONFIG_SW_GRAPHICS), \
	ro.kernel.qemu=1)

PRODUCT_PACKAGES := libGLES_android

subdirs-true :=
subdirs-$(BOARD_USES_DRM_HWCOMPOSER) += drm
subdirs-$(CONFIG_GRALLOC_MALI) += gralloc
$(call inherit-product-dirs, $(subdirs-true))
