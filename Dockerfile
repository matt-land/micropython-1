FROM ubuntu:trusty
RUN apt-get update && \
    apt-get install -y \
    software-properties-common && \
    add-apt-repository -y ppa:terry.guo/gcc-arm-embedded && \
     dpkg --add-architecture i386 && \
     apt-get update -qq && \
     apt-get install -y \
        gcc-multilib \
        gcc-mingw-w64 \
        git \
        libffi-dev \
        libffi-dev:i386 \
        pkg-config \
        python3 \
        python-pip \
        qemu-system \
        # For teensy build
        realpath \
         && \
     apt-get install -y --force-yes gcc-arm-none-eabi && \
     pip install cpp-coveralls && \
     gcc --version && \
     arm-none-eabi-gcc --version && \
     python3 --version && \
     # remove apt cache
     rm -rf /var/lib/apt/lists/*

COPY . /micropython
WORKDIR /micropython/unix
RUN make axtls && \
    make
ENTRYPOINT ./micropython
#ENTRYPOINT tail -f /dev/null