FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get install -y git device-tree-compiler libncurses5 libncurses5-dev build-essential \
    libssl-dev mtools bc python dosfstools bison flex rsync u-boot-tools make curl kmod cpio

RUN mkdir /sdk
WORKDIR /sdk
ADD --chmod=777 build.sh .

ENTRYPOINT [ "/sdk/build.sh" ]
