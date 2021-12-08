# README

## Build docker image

```bash
./gradlew build -x check
docker build -t localhost:5000/boot-app .  
```

```bash
# test regular message
curl http://bootapp.garyks/greet/foo

# test exception output in graylog
curl http://bootapp.garyks/exception
```
