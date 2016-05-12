LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE:= ethernet.rc

LOCAL_INIT_RC := ethernet.rc

include $(BUILD_PHONY_PACKAGE)
