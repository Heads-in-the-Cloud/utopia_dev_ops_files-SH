## Utopia Airlines Docker-Compose Files

This directory contains the Docker-Compose files (in .yml format) for the Utopia Airlines project.

#### public.docker-compose.yml
This file is the portable compose file that should work from anywhere, pulls the latest docker images from public DockerHub repositories. This file can be used to launch in the Default context, a Docker Swarm context, or to an ECS context.

#### local.docker-compose.yml
This file is the local compose file that only works with a full project context (since it attempts to build from the various microservices' source directories).
