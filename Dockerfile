FROM golang:alpine AS builder

WORKDIR /

COPY go.mod .
COPY go.sum .
COPY main.go .



FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /

ARG URL="https://download.blender.org/release/Blender2.92/blender-2.92.0-linux64.tar.xz"

RUN apt update && \
    apt upgrade -y && \
    apt install wget -y && \
    apt install xz-utils -y && \
    apt install libfreetype6 -y && \
    apt install libglu1-mesa -y && \
    apt install libxi6 -y && \
    apt install libxrender1 -y && \
    rm -rf /var/lib/apt/lists/*

RUN wget ${URL} && \
    mkdir /usr/local/blender && \
    tar xf $(basename ${URL}) -C /usr/local/blender --strip-components 1&& \
    rm $(basename ${URL}) && \
    echo "alias blender=./usr/local/blender/blender" >> /root/.bashrc && \
    #mv /usr/local/$(basename ${URL}) /usr/local/blender && \
    mkdir out

CMD [ "/bin/bash" ]