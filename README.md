# EEA Keycloak Theme

This folder contains the EEA Keycloak theme (copied from the Keycloak theme).

For more information regarding how to develop a Keycloak theme, see the [Keycloak server development guide](https://www.keycloak.org/docs/16.1/server_development/index.html#_themes).

## Development

Start the Docker container:

```bash
$ docker-compose up
```

The Keycloak server will be available at [http://localhost:8080]. Once it is running, use the `KEYCLOAK_USER` and `KEYCLOAK_PASSWORD` from the Docker configuration to log into the master realm.

The themes for the master realm are available at the following url:

```
http://localhost:8080/auth/admin/master/console/#/realms/master/theme-settings
```

Update keycloak theme

In order to update the EEA's keycloak theme, the following steps are necessary:

    Execute shell in keycloak-theme container
    Go to /keycloak_theme
    apk add git
    git pull
    Delete the content of the following folder: /opt/keycloak/cache
    Restart keycloak instance(s)
