# ROS 2 Jazzy + Gazebo Harmonic Docker

Docker environment for ROS 2 Jazzy with Gazebo Harmonic. Repository is used for container setup for gazebo sim plugin YouTube tutorials


YouTube Tutorial
----------------
Gazebo Sim Plugin Made Easy !!!

Video link: Coming soon

<br>

## What’s Inside

```text

├── gazebo-sim-plugins-tutorial/  # other repo of ros2 launch & gazebo sim plugins
│   └── ...                        
│
├── Dockerfile   # docker file to make the docker image
├── docker-compose.yaml # docker container setup details 
│
└── README.md
```

## Clone
```bash
git clone https://github.com/Hrithik-verma/ros2-jazzy-gazebo-harmonic-docker.git
git submodule update --init --recursive
```



## Docker Setup 
Build the docker container
```bash
cd ros2-jazzy-gazebo-harmonic-docker
docker compose up -d
```

output:

```
[+] up 2/2ding layer 5f70bf18a086 32B / 32B     0.1s
 ✔ Image jazzy-gz-harmonic-full    Built        323.2s 
 ✔ Container gz-tutorial-container Created     

 ```                                                 

check image
```bash
docker images
```

output:
it shows image we build using ```yt_tuturial_ws/Dockerfile``` 
````
jazzy-gz-harmonic-full:latest             67661f9f23be       3.81GB             0B    U   
````

check image
```bash
docker ps
```

output:
output current running container
```
docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS          PORTS     NAMES
61314940b998   jazzy-gz-harmonic-full          "/ros_entrypoint.sh …"   10 minutes ago   Up 10 minutes             gz-tutorial-container
```

## Run Container

```Important:``` container need to have display access for gazebo gui, rviz gui
```bash
xhost +
```

go inside the container
```bash
docker exec -it gz-tutorial-container bash
```

## Check Container

To check if container is running or not.
Container name not in the list that means it not running
```
docker ps
```

start
```bash
docker start gz-tutorial-container
```
stop
```bash
docker stop gz-tutorial-container
```

## Docker Volume Shared

In ```ros2-jazzy-gazebo-harmonic-docker/docker-compose.yaml``` 

```
 volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw
      - ./gazebo-sim-plugins-tutorial/ros2_ws:/root/ros2_ws
      - ./gazebo-sim-plugins-tutorial/standalone_gz_sim_plugins:/root/standalone_gz_sim_plugins
```

```X11:``` for display access
```ros2_ws```: entire ```ros2_ws``` is mounted inside ```root/ros2_ws```. So any changes we make in ros2_ws will be reflected inside the container.
```standalone_gz_sim_plugins``` similary ```standalone_gz_sim_plugins``` is mounted inside ```root/standalone_gz_sim_plugins```


## Troubleshooting

GUI / Gazebo window not opening (Docker):
- Ensure you ran: xhost +
- Ensure DISPLAY is correctly passed into container (depends on your docker setup)
- Display id is same in host & container
host & docker container should have same ``id``
```bash
echo $DISPLAY
```
output eg:
```bash
$ echo $DISPLAY
:0
```

if not export same display id in host & docker container
```bash
export DISPLAY=:0
```