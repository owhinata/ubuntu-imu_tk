# ubuntu-imu_tk

## Build
```bash
docker build --network host -t ubuntu-imu_tk .
```

## Run
```bash
docker run -it --rm --network host \
-u `id -u`:`id -g` \
-v /etc/passwd:/etc/passwd \
-v /etc/group:/etc/group \
-v $PWD:$PWD -w $PWD \
ubuntu-imu_tk \
test_imu_calib xsens_acc.mat xsens_gyro.mat
```

## Refs.

[imu_tk](https://bitbucket.org/alberto_pretto/imu_tk/)

[ros-imu_tk](https://github.com/Neil-Oyoung/imu_tk/tree/master)
