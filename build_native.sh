#!/bin/bash

if [ "$TARGET_OS" == "android-armv7" || "$TARGET_OS" == "android-armv8" ];
then
  cmake -H. -B build/$TARGET_OS \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION
  cmake --build ./build/$TARGET_OS -v
elif [ "$TARGET_OS" == "ios" ];
then
  mkdir -p ./build/ios/
  clang -arch armv7 -arch arm64 -c ./src/udp_toolkit_native.c -o ./build/ios/udp_toolkit_native.so -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk

# ios toolchain:
# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-ios-tvos-or-watchos
else
  cmake -H. -B build/$TARGET_OS \
  -DCMAKE_BUILD_TYPE=Release
  cmake --build ./build/$TARGET_OS -v
fi

