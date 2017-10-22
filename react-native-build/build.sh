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

#rsync [OPTION]... /temp [SRC]... /temp-dist
echo "sync project to temp-dist"
rsync \
-r \
--exclude 'android' \
--exclude 'ios' \
--exclude 'node_modules' \
--exclude 'yarn.lock' \
--exclude 'package-lock.json' \
--exclude 'npm-shrinkwrap.json' \
/temp/ /temp-dist
echo ""

# go to copied project
echo "cd to /temp-dist"
cd /temp-dist
echo ""

echo "ls -al"
ls -al
echo ""

echo "ls -al node_modules"
ls -al node_modules
echo ""

# install/update node packages
#todo: yarn vs npm
#echo "yarn install"
#yarn install
#echo ""
echo "npm install"
npm install
echo ""

#
#todo:
#check for android/ios folder
#

#eject/generate android and ios project folders
echo "react-native eject"
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
cp -Rf /build/overwrite/android/. ./android/
echo ""

#link native components
#todo: put this in an extra script
echo "react-native link"
react-native link
echo ""

#build
echo "start build android production apk"
cd android && ./gradlew assembleRelease
cd ..
echo "end build android production apk"
echo ""

#post-build-step
echo "start post-build-step"
echo ""
echo "create docker-rnapk-dist"
mkdir -p /temp/docker-rnapk-dist
echo ""
echo "copy build folder to /temp/docker-rnapk-dist"
#todo: maybe use rsync
cp -Rf ./android/app/build/outputs/ /temp/docker-rnapk-dist/
echo "end post-build-step"
echo ""
