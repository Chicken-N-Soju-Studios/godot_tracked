#!/usr/bin/zsh
# Author:Chad Glover

echo "Beginning Build of Linux Mono Editor Binary"
echo  `scons p=linuxbsd -j6 debug_symbols=yes target=editor module_mono_enabled=yes`
sleep 2
pwd
echo " Building debug export templates"

echo `scons p=linuxbsd target=template_debug module_mono_enabled=yes`
sleep 2

echo "building release export templates"
echo `scons p=linuxbsd target=template_release module_mono_enabled=yes`

echo "Generate glue sources"
sleep 2
echo `./bin/godot.linuxbsd.editor.x86_64.mono --headless --generate-mono-glue modules/mono/glue`
# Generate binaries
echo `./modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=linuxbsd`




#COPY FILES TO PROPER DIRECTORY
echo "moving binaries to proper directory"
`cp -r ./bin ./godot_linux_bin`
`cp -r ./godot-cpp/ ./godot_linux_bin`
`rm -rf ./bin`
`zip -r  godot_linux.zip ./godot_linux_bin` 
