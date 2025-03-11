# Docker fah-client-bastet

Multi-arch docker image builder for [FoldingAtHome/fah-client-bastet](https://github.com/FoldingAtHome/fah-client-bastet)

https://hub.docker.com/r/undirectlookable/fah-client-bastet

## Usage

`docker-compose.yml`

```yaml
services:
  app:
    image: undirectlookable/fah-client-bastet
    volumes:
      - ./config.xml:/etc/fah-client/config.xml
      - ./log/:/var/log/fah-client/
    #ports:
    #  - 7396:7396
    dns:
      - 8.8.8.8
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: "0.80"
```

`config.xml`

```xml
<config>
  <!-- Account -->
  <account-token v="TOKEN_FROM_ACCOUNT_SETTINGS" />
  <machine-name v="YOUR_NAME" />
  <!-- User Information -->
  <user v='YOUT_USERNAME'/>
  <!-- HTTP Server -->
  <http-addresses v="0.0.0.0:7396" />
  <allow>0/0</allow>
  <!-- Client Control -->
  <allowed-origins v="https://v8-4.foldingathome.org/ http://localhost:7396" />
</config>
```

Available options can be found by running

```shell
docker run -it --rm undirectlookable/fah-client-bastet --help
```