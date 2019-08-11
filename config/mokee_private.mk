# Use all private apps
PRODUCT_PACKAGES += \
    Aegis \
    Lawnchair \
    Lawnfeed \
    MoKeePay \
    Phonograph \
    ViaBrowser

# Use all private libraries
ifeq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/armeabi-v7a,system/lib)
else ifeq ($(MK_CPU_ABI),x86_64)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/x86,system/lib)
else
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/$(MK_CPU_ABI),system/lib)
endif

# Offline phone location database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/mk-priv/prebuilt/mokee/media/location,system/media/location)

ifneq ($(filter dior find7 m8d m8,$(MK_BUILD)),)
SMALL_BOARD_SYSTEMIMAGE_PARTITION := true
TARGET_BOOTANIMATION_HALF_RES := true
USE_REDUCED_CJK_FONT_WEIGHTS := true
endif

# Default input method apps
ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    LatinIME
else
PRODUCT_PACKAGES += \
    Gboard
endif

# Disable dex-preopt of some devices to save space.
ifeq ($(SMALL_BOARD_SYSTEMIMAGE_PARTITION),true)
# Include MK audio files
include vendor/mk/config/mokee_audio_mini.mk
WITH_DEXPREOPT := false
else
# Include MK audio files
include vendor/mk/config/mokee_audio.mk
PRODUCT_PACKAGES += \
    vim
endif

# Use MoKee build keys
ifneq (${PRODUCT_DEFAULT_MOKEE_CERTIFICATE},)
PRODUCT_DEFAULT_DEV_CERTIFICATE := ${PRODUCT_DEFAULT_MOKEE_CERTIFICATE}/releasekey
else
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/mk-priv/build/target/product/security/releasekey
endif

# Use MoKee Java Source Overlays
ifneq ($(filter PREMIUM,$(MK_BUILDTYPE)),)
JAVA_SOURCE_OVERLAYS := framework|vendor/mk-priv/overlay/premium/frameworks/base|**/*.java
endif