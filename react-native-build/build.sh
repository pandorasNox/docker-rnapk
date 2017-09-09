#!/bin/bash

echo ""

# check if the project folder is mounted to /temp
if [ ! -d "/temp" ]; then
    echo "the project root is not mounted to '/temp'"
    exit
fi
echo "the project is mounted"
echo ""

# go to project root
echo "cd to /temp"
cd /temp
echo ""

#cleaning task
echo "start pre-cleaning"
bash /build/scripts/clean.sh
echo "end pre-cleaning"
echo ""

# check if the project folder is mounted to /temp
if [ ! -d "/apk-signing" ]; then
    echo "the apk-signing material is not mounted to '/apk-signing'"
    exit
fi
echo "the apk-signing material is mounted"
echo ""

if [ ! -e package.json ]
then
    echo "no package.json found"
    exit
fi

#compress .node_modules folder & delete it, if exist
if [[ -d "node_modules" && ! -L "node_modules" ]]; then
    echo "start compressing original node_modules directory"
    tar -zcf original_node_modules.tar.gz node_modules
    rm -r node_modules
    echo "end compressing original node_modules directory"
    echo ""
fi

# install/update node packages
if [ ! -e rnapk_node_modules.tar.gz ]
then
    yarn install
else
    tar -zxf rnapk_node_modules.tar.gz
    yarn install
fi
echo ""

#
#todo:
#check for android/ios folder
#

#eject/generate android and ios project folders
react-native eject
echo ""

#
#todo: check for *.keystore file and gradle.properties file
#differ dev/production
#handle package sign stuff
#
echo "start copy kestore file"
KEYSTORE_FILE=$(find /apk-signing/ -type f | grep -i keystore$)
cp $KEYSTORE_FILE ./android/app/
yes | cp -rf /apk-signing/gradle.properties ./android
echo "end copy kestore file"
echo ""

#handle apk-versioning related tasks
echo "handle apk-versioning"
cp -Rf /build/overwrite/apk-versioning/android/. /temp/android/
echo ""

#link native components
#todo: put this in an extra script
react-native link
echo ""

#build
echo "start build android production apk"
cd android && ./gradlew assembleRelease
echo "end build android production apk"
echo ""

#post-build-cleanup
echo "start post-build-cleanup"
tar -zcf rnapk_node_modules.tar.gz node_modules
rm -r node_modules
if [ -e original_node_modules.tar.gz ]
then
    tar -zxf original_node_modules.tar.gz
    rm original_node_modules.tar.gz
fi
echo "end post-build-cleanup"
echo ""
