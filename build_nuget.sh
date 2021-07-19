#!/bin/bash

mkdir ./UdpToolkit.Network.Native/runtimes
mkdir ./UdpToolkit.Network.Native/runtimes/win-x86
mkdir ./UdpToolkit.Network.Native/runtimes/win-x86/native
mkdir ./UdpToolkit.Network.Native/runtimes/win-x64
mkdir ./UdpToolkit.Network.Native/runtimes/win-x64/native
mkdir ./UdpToolkit.Network.Native/runtimes/osx-x64
mkdir ./UdpToolkit.Network.Native/runtimes/osx-x64/native
mkdir ./UdpToolkit.Network.Native/runtimes/linux-x64
mkdir ./UdpToolkit.Network.Native/runtimes/linux-x64/native
mkdir ./UdpToolkit.Network.Native/runtimes/linux-arm64
mkdir ./UdpToolkit.Network.Native/runtimes/linux-arm64/native


mv ./udp_toolkit_native.dll   ./UdpToolkit.Network.Native/runtimes/win-x64/native
mv ./udp_toolkit_native.dylib ./UdpToolkit.Network.Native/runtimes/osx-x64/native
mv ./udp_toolkit_native.so    ./UdpToolkit.Network.Native/runtimes/linux-x64/native

dotnet pack ./UdpToolkit.Network.Native/UdpToolkit.Network.Native.csproj -c Release -o ./