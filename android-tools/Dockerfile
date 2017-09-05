# Description:
# This Dockerfile tries to provied a base enviroment for dealing with android related tasks
# for this purpose we need the openjdk and the android sdk

# strongly inspired by
# - https://github.com/banianhost/docker-android/blob/master/Dockerfile
#     (https://github.com/banianhost/docker-android/blob/0fcfbb6bbf730d11c111ed9e7dd8d0eea091b790/Dockerfile)
# - https://github.com/gilesp/docker/blob/master/react_native/Dockerfile
#     (https://github.com/gilesp/docker/blob/887c360e835d7381bb500267937a4371450b9e6d/react_native/Dockerfile)

# 1.Step we need the java openjdk
FROM openjdk:8u131

# Set correct environment variables. 23 is needed for react-native
ENV ANDROID_SDK_FILE android-sdk_r23.0.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/$ANDROID_SDK_FILE
ENV ANDROID_HOME /usr/local/android-sdk-linux

# disable interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update -q && \
    apt-get install -y git && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libgcc1:i386 libncurses5:i386 --no-install-recommends && \
    apt-get clean

# Install kvm support for Android emulator
#RUN apt-get install -qy --no-install-recommends qemu-kvm libvirt-bin libegl1-mesa

# Download and untar (install) Android SDK
RUN cd /usr/local && \
    wget $ANDROID_SDK_URL && \
    tar -xzf $ANDROID_SDK_FILE && \
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools && \
    chgrp -R users $ANDROID_HOME && \
    chmod -R 0775 $ANDROID_HOME && \
    rm $ANDROID_SDK_FILE
