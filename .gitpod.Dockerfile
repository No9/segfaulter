FROM quay.io/icdh/segfaulter@sha256:6afa4cc864ac2249d2fd981626a54f4a8fb6ca9b088eb17b8b5d540cb3f2296b as crasher 
# We can get the image from the repoDigest element in the image-info file

FROM quay.io/icdh/default@sha256:5d790e699613caeb9903e6b85654a041d0343db4f24ef4d61d5d5920d261e4ad
# The debug instance to use need to work out how additional tooling such as llnode can be layered in

# We can get the exe location from the dump file - "path" property
COPY --from=crasher /usr/local/bin/segfaulter ./

# We can get the file name from the dump event
ENV CORE_FILE=332420e0-803f-4e1a-903b-bd02393c4681-dump-1643499780-segfaulter-segfaulter-1-4.zip

# We can get the exe location from the dump file "exe" property
ENV EXE_LOCATION=/debug/segfaulter

# This will have to be constructed from the dump_file name
ENV CORE_LOCATION=332420e0-803f-4e1a-903b-bd02393c4681-dump-1643499780-segfaulter-segfaulter-1-4/332420e0-803f-4e1a-903b-bd02393c4681-dump-1643499780-segfaulter-segfaulter-1-4.core


