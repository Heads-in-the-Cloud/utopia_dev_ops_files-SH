## Utopia Airlines Docker-Compose Files

This directory contains the Docker-Compose files (in .yml format) for the Utopia Airlines project.

#### docker-compose.yml
This file is the portable compose file that should work from anywhere, pulls the latest docker images from public DockerHub repositories.

#### local.docker-compose.yml
This file is the local compose file that only works with a full project context (since it attempts to build from the various microservices' source directories).
