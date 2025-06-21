# Description: Dockerfile for a development environment for STM32 applications.
FROM ubuntu:22.04
# Configure timezone (prevents interactive prompts)
ENV TZ="America/Monterrey"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
# This section installs essential packages for building and debugging STM32 applications.
#It includes make, cmake, git, gcc, g++ and other necessary tools.
# It also cleans up the apt cache to reduce image size.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \            
    make \
    wget \    
    tzdata \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install ARM GNU Toolchain to compile STM32 applications
# Note: This is a specific version; you may want to update it as needed.
# The toolchain is downloaded from the official ARM Keil website.
RUN mkdir -p /opt && \
    wget --no-check-certificate https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz -O /opt/arm-gnu-toolchain.tar.xz && \
    tar -xf /opt/arm-gnu-toolchain.tar.xz -C /opt && \
    rm /opt/arm-gnu-toolchain.tar.xz


# Configure user
# This section creates a non-root user with sudo privileges.
# It is recommended to run containers as non-root users for security reasons.
# You can change the USERNAME, USER_UID, and USER_GID as needed.
ARG USERNAME=remoteUser
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
