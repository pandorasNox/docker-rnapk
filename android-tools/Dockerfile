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

#
# Install android tools and system-image
#

# set global env PATH for the android-tools
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/23.0.1

# install android components / sys-img
ENV ANDROID_COMPONENTS platform-tools,build-tools-23.0.1,android-23,extra-android-support,sys-img-x86_64-android-23
RUN echo y | android update sdk \
    --no-ui \
    --force \
    --all \
    --filter "${ANDROID_COMPONENTS}"

#todo: try the following:
#   (while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/android update sdk -u

# install google components
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services
RUN echo y | android update sdk \
    --no-ui \
    --force \
    --all \
    --filter "${GOOGLE_COMPONENTS}"

# SDK licenses agreements
RUN mkdir "$ANDROID_HOME/licenses" || true

# I'll commented the following lines for two reasons:
    # 1. I want that usere are awere that they have to aggree to licenses
    # 2. The licence texts and so the hash valus could change, so hardcoded is not the best option
    # => mounting the licens is imo the best solution

# @see https://stackoverflow.com/a/38381577
# RUN mkdir "$ANDROID_HOME/licenses" || true && \
#     echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" && \
#     echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

# EXPECT MOUNT folder "licenses" to "/usr/local/android-sdk-linux/licenses"

# todo:
# maybe try out a symlink approach, so a user can just mount to something like /andoird-licenses
# and don't have to know the $ANDROID_HOME path
