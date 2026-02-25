$sdlVersion = '3.4.2'

&gh repo clone 'libsdl-org/SDL' src/SDL3 -- -b "release-$sdlVersion" --recursive

&cmake -S src/SDL3 -B build/SDL3 -G "Ninja Multi-Config" -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET="10.13"
&cmake --build build/SDL3 --config Release --target SDL3-shared

New-Item -ItemType "Directory" -Name "artifacts"
Copy-Item "build/SDL3/Release/libSDL3.0.dylib" -Destination "$pwd\artifacts"
