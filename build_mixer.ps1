$sdlVersion = '3.2.4'

&gh repo clone 'libsdl-org/SDL_mixer' src/SDL3_mixer -- -b "release-$sdlVersion" --recursive

# Really please do not use homebrew
&cmake -S src/SDL3_mixer -B build/SDL3_mixer -G "Xcode" -DSDL3_DIR="build/SDL3_installed" -DSDL3_ROOT="build/SDL3_installed" -DSDLMIXER_TESTS_INSTALL=OFF -DSDLMIXER_EXAMPLES_INSTALL=OFF -DSDLMIXER_VENDORED=ON -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET="12.0" -DCMAKE_IGNORE_PATH="/opt/homebrew/bin;/opt/homebrew/lib"

# We disable code signing since we want to sign the entire finished app bundle ourselves later.
&cmake --build build/SDL3_mixer --config Release --target SDL3_mixer-shared -- CODE_SIGNING_ALLOWED=NO

&cmake --install build/SDL3_mixer --prefix build/SDL3_mixer_installed
