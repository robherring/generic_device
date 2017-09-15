#these are all qcom specific (need to split them out somewhere)
PRODUCT_PACKAGES := \
		libwfcu \
		conn_init

PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/qcom-wifi.rc:$(TARGET_OUT_VENDOR)/etc/init/qcom-wifi.rc \
	$(LOCAL_PATH)/start_qcom_wifi.sh:$(TARGET_OUT_VENDOR)/bin/start_qcom_wifi.sh \
	$(LOCAL_PATH)/WCNSS_cfg.dat:$(TARGET_OUT_VENDOR)/firmware/wlan/prima/WCNSS_cfg.dat \
	$(LOCAL_PATH)/WCNSS_qcom_cfg.ini:$(TARGET_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
	$(LOCAL_PATH)/WCNSS_qcom_wlan_nv_flo.bin:$(TARGET_OUT_VENDOR)/etc/wifi/WCNSS_qcom_wlan_nv_flo.bin \
	$(LOCAL_PATH)/WCNSS_qcom_wlan_nv_deb.bin:$(TARGET_OUT_VENDOR)/etc/wifi/WCNSS_qcom_wlan_nv_deb.bin
