FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y git device-tree-compiler libncurses5 libncurses5-dev build-essential libssl-dev mtools bc python dosfstools bison flex rsync u-boot-tools make

RUN mkdir ~/sdk
