# About
docker-rnapk = Docker React Native Android application package building

This project aims to provide you with a command line tool based on Docker to build signed APK files for Android.

## Motivation
coming soon

## example usage
`docker run -it --rm --init -v $(pwd):/temp -v $(pwd)/../apk-signing:/apk-signing -v $(pwd)/../android-licenses:/usr/local/android-sdk-linux/licenses react-native-build`

## container arguments

| Required | What                                | Argument/Example                                                  |
|----------|-------------------------------------|-------------------------------------------------------------------|
| yes      | project directory path              | -v $(pwd):/temp                                                   |
| yes      | android-licenses directory path     | -v /path/to/androidLicenses:/usr/local/android-sdk-linux/licenses |
| yes      | apk-signing material directory path | -v /some/path:/apk-signing                                        |

## How to build signed apk file
### requirements
coming soon
### usage
coming soon


## Testet with the following versions
    "react": "16.0.0-alpha.12",
    "react-native": "0.45.1",

## Todo
- integrate fastlane (optional)
  - https://github.com/appfoundry/fastlane-android-example