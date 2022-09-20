#!/bin/sh

xhost +
docker run -it --privileged -v ~/.Xauthority:/root/.Xauthority \
    -v /tmp/.X11-unix/:/tmp/.X11-unix:rw -e DISPLAY=$DISPLAY \
    -e QT_X11_NO_MITSHM=1 mormj/gr4-runtime-docker:ubuntu-22.04
