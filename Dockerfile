FROM r6-n2-chef
MAINTAINER John Brooker <jeb@hpe.com>

RUN yum -y groupinstall 'Development Tools'
RUN yum -y install git kernel-devel zlib-devel openssl-devel ncurses-devel cmake ruby libssh-devel wget tar libssh2-devel

# libevent2

RUN cd /tmp && \
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz && \
    tar xf libevent-2.0.21-stable.tar.gz && \
    cd libevent-2.0.21-stable && \
    ./configure && \
    make && \
    make install && \
    ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5

# tmate

RUN cd /tmp && \
    git clone https://github.com/nviennot/tmate.git tmate && \
    cd tmate && \
    ./autogen.sh && \
    ./configure --prefix /tmp/out/tmate && \
    make && \
    make install

# tmate-slave

run cd /tmp/out  && \
    git clone https://github.com/nviennot/tmate-slave.git  && \
    cd tmate-slave  && \
    ./create_keys.sh > /tmp/out/keys.txt  && \
    ./autogen.sh  && \
    ./configure  && \
    make
