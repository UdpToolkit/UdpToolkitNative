# TODO: cross compilation not fully supported

# for running on macos host
build-macos:
	cmake -H. -B build/macos -DCMAKE_BUILD_TYPE=Release -DTARGET_OS=macos
	cmake --build ./build/macos -v

# for running on linux host
build-linux:
	cmake -H. -B build/linux -DCMAKE_BUILD_TYPE=Release -DTARGET_OS=linux
	cmake --build ./build/linux -v

# for running on linux host
build-win:
	cmake -H. -B build/win -DCMAKE_BUILD_TYPE=Release -DTARGET_OS=win
	cmake --build ./build/win -v	

build-nugets:
	mkdir -p ./UdpToolkit.Network.Native/runtimes/win-x64/native
	mkdir -p ./UdpToolkit.Network.Native/runtimes/osx-x64/native
	mkdir -p ./UdpToolkit.Network.Native/runtimes/linux-x64/native

	mv ./win-x64/udp_toolkit_native.dll     ./UdpToolkit.Network.Native/runtimes/win-x64/native
	mv ./mac-x64/udp_toolkit_native.dylib   ./UdpToolkit.Network.Native/runtimes/osx-x64/native
	mv ./linux-x64/udp_toolkit_native.so    ./UdpToolkit.Network.Native/runtimes/linux-x64/native

	dotnet pack ./UdpToolkit.Network.Native/UdpToolkit.Network.Native.csproj -c Release -o ./

publish-nugets:
	dotnet nuget push ./UdpToolkit.Network.Native.$PACKAGE_VERSION.nupkg --api-key $NUGET_KEY --source https://api.nuget.org/v3/index.json