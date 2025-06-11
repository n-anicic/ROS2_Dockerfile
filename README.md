# ROS2_Dockerfile
Dockerfile which allows compiling the Rust code for ROS2 on mac and other platforms (and for other programming languages)

## How to build docker

```sh
docker build -t my-ros-humble-desktop .
```

## How to run docker

An example case with folder mappign would be something like this:

```sh
docker run -it --rm \
  -e DISPLAY=192.168.5.13:0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /Users/nikolaanicic/Documents/KaliberProjects/SystemOrchestration:/SysOrchestrator \
  -v /Users/nikolaanicic/Documents/KaliberProjects/Base_Server_ROS2_communicator:/nanicic_communicator\
  --name system_orchestrator \
  my-ros-humble-desktop
```
