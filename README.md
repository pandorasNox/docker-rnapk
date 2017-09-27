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
| yes      | android-licenses directory path     | -v /path/to/androidLicenses:/usr/local/android-sdk-linux/licenses |
| yes      | apk-signing material directory path | -v /some/path:/apk-signing                                        |
| no       | gradle_deps directory path          | -v $(pwd)/../gradle_deps:/temp/gradle_deps                        |


## Testet with the following versions
    "react": "16.0.0-alpha.12",
    "react-native": "0.45.1",

## Todo
- integrate fastlane (optional)
  - https://github.com/appfoundry/fastlane-android-example
- add a versioning script (so you ca adat the apk versionng)