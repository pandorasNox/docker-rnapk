# About
docker-rnapk = Docker React Native Android application package building

This project aims to provide you with a command line tool based on Docker to build signed APK files for Android.

## Motivation
### Backstory
With "Creat React Native App" (CRNA) there exist an awesome tool for getting started with React Native. If you play with the thought to check out React Native you should definitly check out CRNA.

But "Creat React Native App" has limitations:
- for development only
- creats project which are in a kind of pre React Native state (in a context for production)
- it must be written in pure JavaScript
    - you can’t have any dependencies which rely on custom native code (which means you can't use native custome components)
- you have to installed the expo app on a mobile device (or simulator) to show/play around with your app
- devices (running the expo app) needs to be in the same network as the host (who runs a packeging server which streamlinse the JS package to the expo app)
    - sharing your app becomes way harder

At some point you want to distribute your app to coworkers, friends, or customers.
New developers who just startet with CRNA should also make a similar experience if it goes to production.

Here docker-rnapk joins the game.

### Goals
- works for CRNA projects in the first place
- create reproducible results
- reduced time to setup for new developers (well you need use and understand docker)
- you shouldn't need to install Android Studio (or NDK’s) as well
- be as flexible as possible (also support apps with native dependencies)
- enable APK signing
- provide a starting point for CI tools
- be as transparent as possible to understand the deployment/building process

## Get started

### build the docker images
Before you can use this tool you have to create all needed docker images for that purpose.

> Be awere that creating these docker images automatically accepts all kinds of license agreements, it's by the way never a good idea to run any foreign scripts / creating docker images without checking whats happen in there

Its recommended to use the provided init.sh file in this repository.

`bash init.sh` or `./init.sh` after given execution rights to the file

Running this commands creates three images
- android-tools
- react-native-tools
- react-native-build

> the names of the images counts because react-native-build extends react-native-tools and this extends android-tools and

Of course you can create each image manually by running:
`docker build -t android-tools ./android-tools`
`docker build -t react-native-tools ./react-native-tools`
`docker build -t react-native-build ./react-native-build`

### 
coming soon

## example usage
`docker run -it --rm --init -v $(pwd):/temp -v $(pwd)/../apk-signing:/apk-signing -v $(pwd)/../android-licenses:/usr/local/android-sdk-linux/licenses react-native-build`

## How to build signed apk file
### requirements
coming soon
### usage
coming soon

## container arguments

| Required | What                                | Argument/Example                                                  |
|----------|-------------------------------------|-------------------------------------------------------------------|
| yes      | project directory path              | -v $(pwd):/temp                                                   |
| yes      | apk-signing material directory path | -v /some/path:/apk-signing                                        |
| no       | gradle_deps directory path          | -v /some/path:/gradle_deps                                        |


## Testet with the following versions
| React             | React Native         |
|-------------------|----------------------|
| "16.0.0-alpha.12" | "0.45.1"             |


## Todo
- integrate fastlane (optional)
  - https://github.com/appfoundry/fastlane-android-example
- add a versioning script (so you can overwrite the current apk versioning)
