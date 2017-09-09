FROM react-native-tools

COPY scripts /build/scripts
COPY build.sh /build
RUN ["chmod", "-R", "+x", "./build"]

COPY overwrite /build/overwrite

ENTRYPOINT ["./build/build.sh"]

# EXPECT --init
# EXPECT MOUNT VOLUMN of projekt to be at '/temp' => "-v $(pwd):/temp"
