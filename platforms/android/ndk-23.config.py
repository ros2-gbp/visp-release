ABIs = [
    ABI("2", "armeabi-v7a", None, cmake_vars=dict(ANDROID_ABI='armeabi-v7a with NEON', ANDROID_GRADLE_PLUGIN_VERSION='4.1.2', GRADLE_VERSION='7.0')),
    ABI("3", "arm64-v8a",   None, cmake_vars=dict(ANDROID_GRADLE_PLUGIN_VERSION='4.1.2', GRADLE_VERSION='7.0')),
    ABI("5", "x86_64",      None, cmake_vars=dict(ANDROID_GRADLE_PLUGIN_VERSION='4.1.2', GRADLE_VERSION='7.0')),
    ABI("4", "x86",         None, cmake_vars=dict(ANDROID_GRADLE_PLUGIN_VERSION='4.1.2', GRADLE_VERSION='7.0')),
]
