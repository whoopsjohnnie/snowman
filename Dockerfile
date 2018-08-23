
#
# Usage:
# > docker build -t snowman .
# > docker run --rm -e DISPLAY=192.168.0.17:1 -v /tmp/.X11-unix:/tmp/.X11-unix -v /private/tmp:/private/tmp -v /Users/john/Desktop/erdrv1.2.13/:/samples snowman snowman
#

FROM ubuntu:bionic

RUN useradd -m snowman
WORKDIR /home/snowman
ENV HOME /home/snowman

RUN apt-get -y update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y   \
	build-essential                                     \
	cmake                                               \
	git                                                 \
	perl                                                \
	python3                                             \
	bash                                                \
	coreutils                                           \
	wget                                                \
	bc                                                  \
	doxygen                                             \
	graphviz                                            \
	upx                                                 \
	flex                                                \
	bison                                               \
	zlib1g-dev                                          \
	libtinfo-dev                                        \
	autoconf                                            \
	automake                                            \
	pkg-config                                          \
	m4                                                  \
	libtool                                             \
        libboost-all-dev                                    \
        libqt4-dev

USER snowman
RUN git clone https://github.com/whoopsjohnnie/snowman.git && \
	cd snowman && \
	mkdir build && \
	cd build && \
	cmake ../src -DCMAKE_INSTALL_PREFIX=/home/snowman/snowman-install && \
	cmake --build . && \
	cmake --build . --target install

# ENV DISPLAY $DISPLAY
ENV PATH /home/snowman/snowman-install/bin:$PATH
