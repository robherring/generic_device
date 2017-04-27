#these are all qcom specific (need to split them out somewhere)
PRODUCT_PACKAGES := \
		libwfcu \
		conn_init \
		qcom-wifi.rc \

PRODUCT_COPY_FILES := \
	$(LOCAL_PATH)/start_qcom_wifi.sh:system/bin/start_qcom_wifi.sh \
	$(LOCAL_PATH)/WCNSS_cfg.dat:system/vendor/firmware/wlan/prima/WCNSS_cfg.dat \
	$(LOCAL_PATH)/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
	$(LOCAL_PATH)/WCNSS_qcom_wlan_nv_flo.bin:system/etc/wifi/WCNSS_qcom_wlan_nv_flo.bin \
	$(LOCAL_PATH)/WCNSS_qcom_wlan_nv_deb.bin:system/etc/wifi/WCNSS_qcom_wlan_nv_deb.bin
