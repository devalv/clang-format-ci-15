FROM debian:bookworm-slim
RUN apt-get update && \
    apt-get install -y python3 clang-format-15 && \
    rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true
RUN ln -s /usr/bin/clang-format-15 /usr/bin/clang-format
RUN ln -fs /usr/bin/python3 /usr/local/bin/python
ADD ./run-clang-format.py /usr/bin/run-clang-format.py

RUN mkdir /src
WORKDIR /src

ENTRYPOINT ["run-clang-format.py"]
