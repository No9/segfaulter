FROM quay.io/icdh/segfaulter:latest as crasher
                    FROM quay.io/icdh/default@sha256:5d790e699613caeb9903e6b85654a041d0343db4f24ef4d61d5d5920d261e4ad
                    # We can get the exe location from the dump file - "path" property
                    COPY --from=crasher /usr/local/bin/segfaulter ./
                    # We can get the file name from the dump event
                    ENV CORE_FILE=3927906d-5b6d-4ff8-8a61-937bcada155b-dump-1643657577-segfaulter-segfaulter-1-4.zip
                    # We can get the exe location from the dump file "exe" property
                    ENV EXE_LOCATION=/debug/segfaulter
                    # This will have to be constructed from the dump_file name
                    ENV CORE_LOCATION=3927906d-5b6d-4ff8-8a61-937bcada155b-dump-1643657577-segfaulter-segfaulter-1-4/3927906d-5b6d-4ff8-8a61-937bcada155b-dump-1643657577-segfaulter-segfaulter-1-4.core
                    