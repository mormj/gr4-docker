FROM ubuntu:22.04
LABEL maintainer="jmorman@gnuradio.org"

ENV security_updates_as_of 2022-09-20

# Prepare distribution
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -q \
    && apt-get -y upgrade

# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -qy \
    libzmq3-dev \
    doxygen \
    libspdlog-dev \
    libyaml-cpp-dev \
    libgtest-dev \
    libfmt-dev \
    pybind11-dev \
    python3-dev \
    python3-numpy \
    python3-gi \
    python3-gi-cairo gir1.2-gtk-3.0 \
    # libqwt-qt5-dev \
    # qtbase5-dev \
    --no-install-recommends \
    && apt-get clean


# Build deps
RUN mv /sbin/sysctl /sbin/sysctl.orig \
    && ln -sf /bin/true /sbin/sysctl \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    --no-install-recommends \
    build-essential \
    ccache \
    ninja-build \
    libfftw3-dev \
    libgmp-dev \
    libgsl0-dev \
    python3-matplotlib \
    && rm -f /sbin/sysctl \
    && ln -s /usr/bin/ccache /usr/lib/ccache/cc \
    && ln -s /usr/bin/ccache /usr/lib/ccache/c++ \
    && mv /sbin/sysctl.orig /sbin/sysctl

# Install other dependencies (e.g. VOLK)
RUN apt-get -y install -q \
    git \
    python3-pip \
    cmake \
    pkg-config \
    ca-certificates \
    libsoapysdr-dev \
    libasound2 \
    portaudio19-dev \
    libvolk2-dev \
    --no-install-recommends
RUN apt-get clean
RUN apt-get autoclean

RUN pip install meson ninja mako jinja2 pyyaml zmq jsonschema jsonschema-default packaging

RUN git clone https://github.com/gnuradio/gnuradio /src/build/ --depth 1 --branch dev-4.0 
RUN cd /src/build && meson setup build && cd build && ninja && ninja install && rm -rf /src


ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python3/dist-packages:/usr/local/lib/python3.10/dist-packages
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib/

RUN ldconfig