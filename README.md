# docker-rnapk
docker react-native android application package building

docker run -it --rm --init react-native-build

## container arguments

| What                                | Argument/Example                                                  |
|-------------------------------------|-------------------------------------------------------------------|
| project directory path              | -v $(pwd):/temp                                                   |
| android-lizenses directory path     | -v /path/to/androidLicenses:/usr/local/android-sdk-linux/licenses |
| apk-signing material directory path | -v /some/path:/apk-signing                                        |

## example
`docker run -it --rm --init -v $(pwd):/temp -v $(pwd)/../apk-signing:/apk-signing  react-native-build`
