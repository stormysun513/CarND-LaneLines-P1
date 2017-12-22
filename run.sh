#!/bin/bash

# docker run is the command a startup and run a Docker container.
# `-it` forces the container to run in the foreground (interactive mode) 
# and provides an I/O to the container. 
# `--rm` removes the container once it stops running. It prevents the 
# buildup of stale containers once you stop them from running.
# `-p 8888:8888` maps port 8888 on our local machine to port 8888 in 
# the Docker container, this allows us to access port 8888 in the container 
# by visiting localhost:8888.
# `-v ${pwd}:/src` mounts the pwd (present working directory) to 
# the /src directory in the container. Basically, this lets us 
# access files from our local machine on the docker container.
# udacity/carnd-term1-starter-kit is the name of the container to run.


docker run -it --rm -p 8888:8888 -v "`pwd`":/src udacity/carnd-term1-starter-kit P1.ipynb
