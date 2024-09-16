#!/usr/bin/zsh
# Author:Chad Glover

echo "Beginning Build of Windows Mono Editor Binary"
echo  `scons p=windows -j12  target=editor module_mono_enabled=yes`
sleep 2
pwd
echo " Building debug export templates"

echo `scons p=windows target=template_debug module_mono_enabled=yes`
sleep 2

echo "building release export templates"
echo `scons p=windows target=template_release module_mono_enabled=yes`

echo "Generate glue sources"
sleep 2
echo `./bin/godot.windows.editor.x86_64.mono.exe --headless --generate-mono-glue bin/modules/mono/glue`
# Generate binaries
echo `./modules/mono/build_scripts/build_assemblies.py --godot-output-dir=./bin --godot-platform=windows`



echo "Moving binaries into windows directory"
`cp -r ./bin ./godot_windows`
`cp -r ./godot-cpp ./godot_windows`
`rm -rf ./bin`
`zip -r godot_windows.zip ./godot_windows`
echo "Build Completed"
