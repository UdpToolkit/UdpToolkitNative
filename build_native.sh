#!/bin/bash

if [ "$TARGET_OS" == "android-armv7" || "$TARGET_OS" == "android-armv8" ];
then
  cmake -H. -B build/$TARGET_OS \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION
elif [ "$TARGET_OS" == "ios" ];
then
  cmake -H. -B build/$TARGET_OS \
      -DCMAKE_BUILD_TYPE=Release \
      -G Xcode -B build/$TARGET_OS \
      -DCMAKE_SYSTEM_NAME=iOS \
      -DCMAKE_Swift_COMPILER_FORCED=true \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0

# ios toolchain:
# https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-ios-tvos-or-watchos
else
  cmake -H. -B build/$TARGET_OS \
  -DCMAKE_BUILD_TYPE=Release
fi

cmake --build ./build/$TARGET_OS -v
