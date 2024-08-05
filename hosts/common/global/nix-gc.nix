{ config, lib, pkgs, inputs, ... }:
let
  makeJobScript = (import "${inputs.nixpkgs}/nixos/lib/utils.nix" { inherit lib config pkgs; }).systemdUtils.lib.makeJobScript;
  cfg = config.nix.gc;
in {

  options.nix.gc.nixEnvOptions = lib.mkOption {
    default = "";
    example = "--delete-generations +3";
    type = lib.types.singleLineStr;
    description = ''
      Options given to [`nix-env`](https://nixos.org/manual/nix/stable/command-ref/nix-env) before the garbage collector is run automatically.
    '';
  };

  config = {
    systemd.services.nix-gc.serviceConfig.ExecStart = lib.mkForce (makeJobScript "nix-gc-start" (
        (if cfg.nixEnvOptions != "" then "${config.nix.package.out}/bin/nix-env ${cfg.nixEnvOptions}" else "") +
        "\n" + 
        "${config.nix.package.out}/bin/nix-collect-garbage ${cfg.options}"
      )
    );
  };
}
