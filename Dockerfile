FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    bash -c ' \
      rm -f /etc/apt/sources.list.d/ros2.sources && \
      \
      apt-get update && \
      apt-get install -y curl gnupg lsb-release && \
      \
      curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
      \
      echo "Types: deb \
URIs: http://packages.ros.org/ros2/ubuntu \
Suites: $(lsb_release -cs \
Components: main \
Signed-By: /usr/share/keyrings/ros-archive-keyring.gpg" > /etc/apt/sources.list.d/ros2.sources && \
      \
      apt-get update'

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    curl \
    build-essential \
    git \
    protobuf-compiler \
    tree \
    mesa-utils \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    ros-humble-rviz2 \
    python3-pip \
    clang \
    libclang-dev\
    pkg-config \
    libglib2.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-tools \
    # Now for python ROS2 robot simulator support
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    ros-humble-rclpy \
    ros-humble-std-msgs \
    ros-humble-std-srvs \
    python3-gst-1.0 \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    # ros-humble-turtlesim \
    x11-apps && \
    # Clean up apt cache to keep image smaller
    rm -rf /var/lib/apt/lists/*

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
