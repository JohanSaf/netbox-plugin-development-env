# netbox-plugin-development-env

This is a fork of [dkraklan/netbox-plugin-development-env](https://github.com/dkraklan/netbox-plugin-development-env), with modifications to fit my workflow and style better.

---

When developing NetBox plugins having an easily reproducible dev enviroment can be difficult. This project will provide a Docker container pre configured with NetBox and will automatically reload when changes are detected with the plugin you are working on.

The project is still young at this point and I'm using it regularly in my workflow so it will mature and stabilize with that. It's missing many configuration options for netbox, as well as some netbox features likely dont work related to media and jobs. It's not meant to be used for any sort of production netbox installation.

### Goals
- Easily (re)creatable development enviroment.
- Local copy of all modules for IDE/LSP to use to ensure valid auto complete.
- Hot reload when developing plugin.


## Install
### Quickstart
```bash
git clone git@github.com:JohanSaf/netbox-plugin-development-env.git
make run
```
You will now have a local instance of netbox runinng on http://127.0.0.1:8000 , username and password are defiend in the `netbox.env`file.

### Setting up your plugin
Clone your plugin into the `plugins/` directory. Then edit the `configuration/configuration.py` file and add your plugin to the plugins section.
```bash
make run
```

### Migrations
When you need to make further migrations during devleopment you can do that with the make options.
```bash
make migrations #Generate core migrations
PLUGIN=test_plugin make migrations #Generate migrations for a plugin named test_plugin
make migrate
```
You can also drop into the dbshell and nbshell.

```bash
make dbshell
make nbshell
```

## Usage
This commands are available using the `Makefile`:
```
Usage:
  help         print this help message
  run          build and run the containers
  restart      restart the containers
  stop         stop the containers
  open         open netbox in the web browser (macos only)
  clean        remove the local netbox clone, docker containers and associated volumes
  migrations   create migrations, use PLUGIN=plugin_name to create migrations for a plugin
  migrate      apply migrations
  nbshell      execute the netbox shell
  dbshell      execute the postgres database shell
```

## Credits
I combined a few different development setups I saw from other plugins as well as some of the scripts from the official docker image.

[Netbox Docker](https://github.com/netbox-community/netbox-docker)

[netbox-config-diff](https://github.com/miaow2/netbox-config-diff/tree/develop)

[netbox-acls](https://github.com/netbox-community/netbox-acls/)
