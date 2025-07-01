FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends build-essential cmake curl git python3-pip vim clang netcat libclang-dev pkg-config && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends python3-colcon-common-extensions python3-rosdep python3-vcstool ros-humble-rmw-cyclonedds-cpp ros-humble-rclpy ros-humble-std-msgs ros-humble-std-srvs ros-humble-rviz2 && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends iputils-ping net-tools iproute2 protobuf-compiler tree mesa-utils libgl1-mesa-glx libgl1-mesa-dri libglib2.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-tools python3-gst-1.0 gir1.2-gstreamer-1.0 gir1.2-gst-plugins-base-1.0 x11-apps && rm -rf /var/lib/apt/lists/*

# Reset the environment variable
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain stable \
    && chmod -R a+w $RUSTUP_HOME $CARGO_HOME
RUN cargo install sqlx-cli --no-default-features --features sqlite,postgres
RUN pip install gst
ENV DEBIAN_FRONTEND=

ENV LIBGL_ALWAYS_INDIRECT=1

WORKDIR /ros_ws

CMD ["/bin/bash"]
