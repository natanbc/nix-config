{ config, lib, ... }: {
  imports = [
    ./anubis.nix
    ./nginx.nix
  ];

  age.secrets = {
    forgejo-jwt-secret = {
      file = ./jwt-secret.age;
      owner = config.services.forgejo.user;
      group = config.services.forgejo.group;
    };
    forgejo-secret-key = {
      file = ./secret-key.age;
      owner = config.services.forgejo.user;
      group = config.services.forgejo.group;
    };
  };

  networking.firewall.allowedTCPPorts = [
    config.services.forgejo.settings.server.SSH_PORT
  ];

  services.forgejo = {
    enable = true;

    database.type = "sqlite3";
    stateDir = config.fileSystems."/var/lib/forgejo".mountPoint;

    secrets = {
      oauth2 = {
        JWT_SECRET = lib.mkForce config.age.secrets.forgejo-jwt-secret.path;
      };
      security = {
        SECRET_KEY = lib.mkForce config.age.secrets.forgejo-secret-key.path;
      };
    };

    settings.DEFAULT = {
      APP_NAME = "git.natanbc.net";
    };
    settings.actions = {
      # No ACE for now
      ENABLED = false;
    };
    settings.database = {
      SQLITE_JOURNAL_MODE = "WAL";
    };
    settings.federation = {
      ENABLED = false;
    };
    settings.log = {
      ROOT_PATH = config.fileSystems."/var/log".mountPoint + "/forgejo";
    };
    settings.oauth2 = {
      JWT_SIGNING_ALGORITHM = "HS256";
    };
    settings.oauth2_client = {
      ENABLE_AUTO_REGISTRATION = true;
      USERNAME = "nickname";
      UPDATE_AVATAR = true;
    };
    settings.repository = {
      DEFAULT_PRIVATE = "private";
      ENABLE_PUSH_CREATE_USER = true;
      ENABLE_PUSH_CREATE_ORG = true;
      DEFAULT_REPO_UNITS = "repo.code,repo.releases";
    };
    settings."repository.local" = {
      LOCAL_COPY_PATH = "/tmp/forgejo-repository-copy";
    };
    settings."repository.signing" = {
      DEFAULT_TRUST_MODEL = "committer";
    };
    settings."repository.upload" = {
      TEMP_PATH = "/tmp/forgejo-repository-uploads";
    };
    settings.server = {
      DISABLE_SSH = false;
      DOMAIN = "git.natanbc.net";
      HTTP_ADDR = "/run/forgejo/forgejo.sock";
      PROTOCOL = "http+unix";
      ROOT_URL = "https://git.natanbc.net";
      SSH_PORT = 2222;
      START_SSH_SERVER = true;
      SSH_SERVER_USE_PROXY_PROTOCOL = true;
    };
    settings.service = {
      AUTO_WATCH_NEW_REPOS = false;
      DISABLE_REGISTRATION = true;
      ALLOW_ONLY_EXTERNAL_REGISTRATION = true;
    };
    settings."service.explore" = {
      REQUIRE_SIGNIN_VIEW = true;
    };
    settings.session = {
      COOKIE_SECURE = true;
      DOMAIN = "git.natanbc.net";
    };
    settings."ssh.minimum_key_sizes" = {
      # Use modern crypto. ECDSA allowed only because some secure enclaves can't do Ed25519
      RSA = -1;
    };
    settings."ui.meta" = {
      AUTHOR = "git.natanbc.net";
      DESCRIPTION = "natan's git forge";
    };
  };
}
