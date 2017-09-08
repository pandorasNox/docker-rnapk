FROM react-native-tools

COPY build.sh .
RUN ["chmod", "+x", "./build.sh"]


ENTRYPOINT ["./build.sh"]

# EXPECT --init
# EXPECT MOUNT VOLUMN of projekt to be at '/temp' => "-v $(pwd):/temp"
