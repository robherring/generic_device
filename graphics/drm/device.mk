PRODUCT_PACKAGES := \
		libGLES_mesa \
		hwcomposer.drm \
		gralloc.gbm \
		android.hardware.graphics.composer@2.1-service \
		android.hardware.graphics.composer@2.1-impl \
		android.hardware.graphics.mapper@2.0-impl \
		android.hardware.graphics.allocator@2.0-service \
		android.hardware.graphics.allocator@2.0-impl

PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/drm.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/drm.rc
