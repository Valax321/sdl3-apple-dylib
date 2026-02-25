$sdlVersion = '3.4.2'

&gh repo clone 'libsdl-org/SDL' src/SDL3 -- -b "release-$sdlVersion" --recursive

# We need to ignore homebrew entirely to be sure the output doesn't depend on anything that may be installed.
# This also means we need to use Xcode instead of ninja.
&cmake -S src/SDL3 -B build/SDL3 -G "Xcode" -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET="10.13" -DCMAKE_IGNORE_PATH="/opt/homebrew/bin;/opt/homebrew/lib"

# We disable code signing since we want to sign the entire finished app bundle ourselves later.
&cmake --build build/SDL3 --config Release --target SDL3-shared -- CODE_SIGNING_ALLOWED=NO

New-Item -ItemType "Directory" -Name "artifacts"
Copy-Item "build/SDL3/Release/libSDL3.0.dylib" -Destination "$pwd\artifacts"
