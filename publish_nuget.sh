#!/bin/bash

dotnet nuget push ./UdpToolkit.Network.Native.$PACKAGE_VERSION.nupkg --api-key $NUGET_KEY --source https://api.nuget.org/v3/index.json
