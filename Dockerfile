FROM ubuntu:trusty
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:terry.guo/gcc-arm-embedded && \
     dpkg --add-architecture i386 && \
     apt-get update -qq || true && \
     apt-get install -y \
        python3 \
        gcc-multilib \
        pkg-config \
        libffi-dev \
        libffi-dev:i386 \
        qemu-system \
        python-pip \
        # For teensy build
        realpath \
        gcc-mingw-w64 && \
     apt-get install -y --force-yes gcc-arm-none-eabi
RUN pip install cpp-coveralls && \
     gcc --version && \
     arm-none-eabi-gcc --version && \
        python3 --version

COPY . /micropython

WORKDIR /micropython/unix
#RUN cd unix && \
#    make axtls && \
#    make
#ENTRYPOINT ./micropython
ENTRYPOINT tail -f /dev/null