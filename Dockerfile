FROM ros:jazzy

RUN apt-get update && apt-get install -y \
      locales lsb-release wget curl gnupg2 git build-essential \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Just install the ROS meta-package:
RUN apt-get update && \
    apt-get install -y ros-jazzy-ros-gz \
    && rm -rf /var/lib/apt/lists/*


##  bash completion
# Use bash for RUN so "source" works when we test things in RUN steps
SHELL ["/bin/bash", "-lc"]

RUN cat >> /etc/bash.bashrc <<'EOF'
# ROS environment
if [ -n "$ROS_DISTRO" ] && [ -f "/opt/ros/$ROS_DISTRO/setup.bash" ]; then
  source "/opt/ros/$ROS_DISTRO/setup.bash"
fi

# bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

# colcon completion
if [ -f /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash ]; then
  source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
fi

# ros2 completion via argcomplete
if command -v register-python-argcomplete >/dev/null 2>&1; then
  eval "$(register-python-argcomplete ros2)"
elif command -v register-python-argcomplete3 >/dev/null 2>&1; then
  eval "$(register-python-argcomplete3 ros2)"
fi
EOF


WORKDIR /root/




