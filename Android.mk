#
# Copyright (C) 2022 The LeafOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := BromiteWebView
LOCAL_MODULE_CLASS := APPS
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_OVERRIDES_PACKAGES := webview
LOCAL_SRC_FILES := prebuilt/$(TARGET_ARCH)_SystemWebView.apk
include $(BUILD_PREBUILT)

$(PRODUCT_OUT)/obj/BROMITE/$(TARGET_ARCH)_ChromePublic.apk: $(MINIGZIP)
	@rm -rf $(dir $@)
	@mkdir -p $(dir $@)
	@$(MINIGZIP) -c -d packages/apps/Bromite/prebuilt/$(TARGET_ARCH)_ChromePublic.apk.gz > $@

include $(CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := Bromite
LOCAL_MODULE_CLASS := APPS
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_OVERRIDES_PACKAGES := Browser2
LOCAL_SRC_FILES := ../../../$(PRODUCT_OUT)/obj/BROMITE/$(TARGET_ARCH)_ChromePublic.apk
include $(BUILD_PREBUILT)
