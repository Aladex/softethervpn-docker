# SoftEther VPN Docker Images

[![Build SoftEther VPN Docker Images](https://github.com/Aladex/softethervpn-docker/actions/workflows/build.yml/badge.svg)](https://github.com/Aladex/softethervpn-docker/actions/workflows/build.yml)

Multi-architecture Docker images for SoftEther VPN (server, client, bridge), built automatically from the official [SoftEtherVPN](https://github.com/SoftEtherVPN/SoftEtherVPN) source.

## Images

| Component | Image |
|-----------|-------|
| Server | `aladex/softethervpn_server` |
| Client | `aladex/softethervpn_client` |
| Bridge | `aladex/softethervpn_bridge` |

**Architectures:** `linux/amd64`, `linux/arm64`

## Quick Start

```bash
docker run -d --name vpnserver \
  --cap-add NET_ADMIN \
  -v vpn_config:/mnt \
  -p 443:443 -p 992:992 -p 1194:1194/udp -p 5555:5555 \
  aladex/softethervpn_server:latest
```

## Tags

- `latest` — built from the most recent upstream tag
- `<version>` — specific SoftEther release (e.g. `5.2.5188`)

## Building Locally

```bash
# Server (default)
docker buildx build --build-arg COMPONENT=server --build-arg SOFTETHER_TAG=5.2.5188 -t softether-server .

# Client
docker buildx build --build-arg COMPONENT=client -t softether-client .

# Bridge
docker buildx build --build-arg COMPONENT=bridge -t softether-bridge .
```

Omit `SOFTETHER_TAG` to build from the latest master branch.

## CI/CD

GitHub Actions workflow runs daily, checks for new upstream tags in `SoftEtherVPN/SoftEtherVPN`, and automatically builds + pushes all three components for both architectures. Can also be triggered manually via `workflow_dispatch`.

## License

Same license as the official [SoftEtherVPN repository](https://github.com/SoftEtherVPN/SoftEtherVPN).
