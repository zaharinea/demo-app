# demo-app

_your application description_

## Commands
* `make dep` - Installs dependencies to ./.rocks folder
* `make run` - Runs Tarantool instance locally inside the ./.tnt/init folder.
* `make test` - Runs tests from ./t folder

## Deploy
To deploy application the recommended directory structure is the following:
```
/
├── etc
│   └── demo-app
│       └── conf.lua
└── usr
    └── share
        └── demo-app
            ├── init.lua
            ├── app/
            └── .rocks/
```
You need to put a symlink `/etc/tarantool/instances.enabled/demo-app.lua -> /usr/share/demo-app/init.lua
` and you are ready to start your application by either `tarantoolctl start demo-app` or, if you're using systemd - `systemctl start tarantool@demo-app`

## Docker
```
docker build -t demo-app .
docker run -p 12345:12345 -p 3301:3301 -e TARANTOOL_USER_NAME=demo -e TARANTOOL_USER_PASSWORD=demo demo-app
```