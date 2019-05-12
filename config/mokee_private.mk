# Default input method apps
PRODUCT_PACKAGES += \
		Gboard

# Use all private libraries
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/arm64-v8a,system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk-priv/prebuilt/mokee/lib/armeabi-v7a,system/lib)

# Offline phone location database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/mk-priv/prebuilt/mokee/media/location,system/media/location)
