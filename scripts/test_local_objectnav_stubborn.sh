#!/usr/bin/env bash

docker run \
    -v $(pwd)/habitat-challenge-data:/habitat-challenge-data \
    --runtime=nvidia \
    -e "AGENT_EVALUATION_TYPE=local" \
    -e "TRACK_CONFIG_FILE=/configs/challenge_objectnav2021.local.rgbd.yaml" \
    -v /media/corallab-s1/2tbhdd/Xuyang/rich-maps/RichMaps:/RichMaps/  \
    -it \
    -w /RichMaps \
    --network=host --ipc=host  \
    --device=/dev/dri:/dev/dri \
    -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
    -v $HOME/.Xauthority:/home/$(id -un)/.Xauthority -e XAUTHORITY=/home/$(id -un)/.Xauthority \
    objectnav_submission \

