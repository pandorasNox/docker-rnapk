FROM react-native-tools

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends rsync && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# create temp-dist where the build.sh script later works in
# aöso enable a mounting point in order to persit node_modules
RUN mkdir -p /temp-dist

COPY scripts /build/scripts
COPY build.sh /build
RUN ["chmod", "-R", "+x", "./build"]

COPY overwrite /build/overwrite

ENTRYPOINT ["./build/build.sh"]

# EXPECT --init
# EXPECT MOUNT VOLUMN of projekt to be at '/temp' => "-v $(pwd):/temp"
