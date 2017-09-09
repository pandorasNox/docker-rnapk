# docker-rnapk
docker react-native android application package building

docker run -it --rm --init react-native-build

## container options

| What                            | Argument/Example                                           |
|---------------------------------|------------------------------------------------------------|
| project directory path          | -v $(pwd):/temp                                            |
| android-lizenses directory path | -v myAndroidLicenses:/usr/local/android-sdk-linux/licenses |
