# SoftEtherVPN Docker Images

This repository contains three Dockerfiles for personal use. You can also use them. I personally build them in Jenkins and push them to DockerHub.

## Dockerfiles

- **Dockerfile.bridge**: This Dockerfile builds a SoftEtherVPN bridge. It clones the SoftEtherVPN repository, compiles the source code, and sets up the necessary environment to run the VPN bridge.

- **Dockerfile.client**: This Dockerfile builds a SoftEtherVPN client. Similar to the bridge Dockerfile, it clones the SoftEtherVPN repository, compiles the source code, and sets up the environment to run the VPN client.

- **Dockerfile.server**: This Dockerfile builds a SoftEtherVPN server. It follows the same steps as the other Dockerfiles, cloning the repository, compiling the source code, and setting up the environment to run the VPN server.

## Build Process

All Dockerfiles use the latest `alpine` image to ensure the most up-to-date base environment. The build process involves:

1. Cloning the SoftEtherVPN repository.
2. Installing necessary dependencies.
3. Compiling the SoftEtherVPN source code.
4. Setting up the runtime environment.

## Official Repository

Please note, this is **not** the official repository for SoftEtherVPN. If you are looking for the source code or official documentation, you can find it here:

[SoftEtherVPN Official GitHub Repository](https://github.com/SoftEtherVPN/SoftEtherVPN)

This Docker image is used for building and checking SoftEtherVPN updates, with commits and tags from the official branch.

## License

This project follows the same license as the official SoftEtherVPN repository. For more information, check the license in the official repository.