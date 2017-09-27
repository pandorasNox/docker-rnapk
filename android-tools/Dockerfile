# Description:
# This Dockerfile tries to provied a base enviroment for dealing with android related tasks
# for this purpose we need
    # - the openjdk
    # - the android sdk

# strongly inspired by
# - https://github.com/banianhost/docker-android/blob/master/Dockerfile
#     (https://github.com/banianhost/docker-android/blob/0fcfbb6bbf730d11c111ed9e7dd8d0eea091b790/Dockerfile)
# - https://github.com/gilesp/docker/blob/master/react_native/Dockerfile
#     (https://github.com/gilesp/docker/blob/887c360e835d7381bb500267937a4371450b9e6d/react_native/Dockerfile)

# we need the java openjdk
FROM openjdk:8u131

# Set correct environment variables. 23 is needed for react-native
ENV ANDROID_SDK_FILE android-sdk_r23.0.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/$ANDROID_SDK_FILE
ENV ANDROID_HOME /usr/local/android-sdk-linux

# disable interactive mode
ENV DEBIAN_FRONTEND noninteractive

# what happens here I didn't figured out completly yet (why do we need all this)
RUN dpkg --add-architecture i386 && \
    apt-get update -q && \
    apt-get install -y git && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libgcc1:i386 libncurses5:i386 --no-install-recommends && \
    apt-get clean

# Install kvm support for Android emulator
#RUN apt-get install -qy --no-install-recommends qemu-kvm libvirt-bin libegl1-mesa

#
#
#

# Download and untar (install) Android SDK
RUN cd /usr/local && \
    wget $ANDROID_SDK_URL && \
    tar -xzf $ANDROID_SDK_FILE && \
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools && \
    chgrp -R users $ANDROID_HOME && \
    chmod -R 0775 $ANDROID_HOME && \
    rm $ANDROID_SDK_FILE

#
# Install android tools and system-image
#

# set global env PATH for the android-tools
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/23.0.1

# create SDK licenses agreements directory
RUN mkdir "$ANDROID_HOME/licenses" || true

# install android components / sys-img
ENV ANDROID_COMPONENTS platform-tools,build-tools-23.0.1,android-23,extra-android-support,sys-img-x86_64-android-23,extra-android-m2repository
RUN (while sleep 3; do echo "y"; done) | android update sdk \
    --no-ui \
    --force \
    --all \
    --filter "${ANDROID_COMPONENTS}"

# install google components
# ENV GOOGLE_COMPONENTS extra-google-m2repository,extra-google-google_play_services
# RUN (while sleep 3; do echo "y"; done) | android update sdk \
#     --no-ui \
#     --force \
#     --all \
#     --filter "${GOOGLE_COMPONENTS}"

# alternativly install just all updates, images sizes are close to each other (5.25 GB to 5.5 GB)
#(while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/android update sdk -u

#
#
#

# Tell gradle to store dependencies in a sub directory of the android project
# this persists the dependencies between builds
ENV GRADLE_USER_HOME /gradle_deps

# OPTIONAL MOUNT folder to "/gradle_deps"
