FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
  build-essential cmake gnuplot vim git wget unzip \
  libqt4-dev libqt4-opengl-dev freeglut3-dev \
  libeigen3-dev libatlas-base-dev \
  libsuitesparse-dev libmetis-dev \
  libgflags-dev libgoogle-glog-dev \
  libboost-dev libxmu-dev libxi-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/src
RUN git clone -b 1.14.0 https://ceres-solver.googlesource.com/ceres-solver
RUN mkdir -p ceres-solver/build && \
    cd ceres-solver/build && \
    cmake .. && make install

WORKDIR /usr/local/src
RUN wget https://bitbucket.org/alberto_pretto/imu_tk/get/7780270fb9a2.zip && \
    unzip 7780270fb9a2.zip && \
    sed -i \
      -e 's/init_acc_calib\.setBias( Vector3d(32768, 32768, 32768) );/init_acc_calib.setBias( Vector3d(0, 0, 0) );/' \
      -e 's/init_gyro_calib\.setScale( Vector3d(1\.0\/6258\.0, 1\.0\/6258\.0, 1\.0\/6258\.0) );/init_gyro_calib\.setScale( Vector3d(1\.0, 1\.0, 1\.0) );/' \
      -e 's/mp_calib.setInitStaticIntervalDuration(50\.0);/mp_calib.setInitStaticIntervalDuration(10\.0);/' \
      -e 's/mp_calib.setGravityMagnitude(9\.81744);/mp_calib.setGravityMagnitude(9\.7975);/' \
    alberto_pretto-imu_tk-7780270fb9a2/apps/test_imu_calib.cpp
RUN mkdir -p alberto_pretto-imu_tk-7780270fb9a2/build && \
    cd alberto_pretto-imu_tk-7780270fb9a2/build && \
    cmake .. && make && \
    cp ../bin/test_imu_calib /usr/bin/

