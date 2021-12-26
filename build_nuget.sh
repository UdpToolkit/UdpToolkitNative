#!/bin/bash

# desktop platforms
mkdir -p ./UdpToolkit.Network.Native/runtimes/win-x86/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/win-x64/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/osx-x64/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/linux-x64/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/linux-arm64/native

# mobile platforms
mkdir -p ./UdpToolkit.Network.Native/runtimes/android-armv7/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/android-armv8/native
mkdir -p ./UdpToolkit.Network.Native/runtimes/ios/native

# desktop platforms
mv ./win-x64/udp_toolkit_native.dll     ./UdpToolkit.Network.Native/runtimes/win-x64/native
mv ./mac-x64/udp_toolkit_native.dylib   ./UdpToolkit.Network.Native/runtimes/osx-x64/native
mv ./linux-x64/udp_toolkit_native.so    ./UdpToolkit.Network.Native/runtimes/linux-x64/native

# mobile platforms
mv ./android-armv7/udp_toolkit_native.so    ./UdpToolkit.Network.Native/runtimes/android-armv7/native
mv ./android-armv8/udp_toolkit_native.so    ./UdpToolkit.Network.Native/runtimes/android-armv8/native
mv ./ios/udp_toolkit_native.so              ./UdpToolkit.Network.Native/runtimes/ios/native

dotnet pack ./UdpToolkit.Network.Native/UdpToolkit.Network.Native.csproj -c Release -o ./