let
  partUUIDs = [
    "43e11d47-e060-4b5c-87da-844ced6a0ad0"
    "f1ba60a9-f2c4-4168-987e-39c397a07f7f"
  ];
in {
  age.secrets = builtins.listToAttrs (builtins.map (uuid: {
    name = "luks-key-${uuid}";
    value = {
      file = ./. + "/luks-key-${uuid}.age";
    };
  }) partUUIDs);
}
