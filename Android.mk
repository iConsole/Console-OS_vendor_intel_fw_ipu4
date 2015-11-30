LOCAL_PATH:= $(call my-dir)

camera_fw := ipu4_isys_bxt_fw_a0.bin ipu4_isys_bxt_fw_b0.bin

ifeq ($(BUILD_CAM_FW_IN_RAMDISK),true)
CAM_FW_ROOT := $(TARGET_ROOT_OUT)/lib/firmware
CAM_FW_TAGS := eng debug tests
else
CAM_FW_ROOT := $(TARGET_OUT_ETC)/firmware
CAM_FW_TAGS := optional
endif

# function to copy firmware libraries to /etc/firmware
define camera-prebuilt-boilerplate
$(foreach t,$(1), \
  $(eval include $(CLEAR_VARS)) \
  $(eval tw := $(subst :, ,$(strip $(t)))) \
  $(eval LOCAL_MODULE := $(tw)) \
  $(eval LOCAL_MODULE_OWNER := intel) \
  $(eval LOCAL_MODULE_TAGS := $(CAM_FW_TAGS)) \
  $(eval LOCAL_MODULE_CLASS := ETC) \
  $(eval LOCAL_MODULE_PATH := $(CAM_FW_ROOT)) \
  $(eval LOCAL_SRC_FILES := $(tw)) \
  $(eval include $(BUILD_PREBUILT)) \
)
endef

# build ISP and FW
$(call camera-prebuilt-boilerplate, \
    $(camera_fw))
