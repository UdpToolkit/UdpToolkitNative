#!/bin/bash

cmake -H. -B build/$TARGET_OS -DCMAKE_BUILD_TYPE=Release
cmake --build ./build/$TARGET_OS -v
