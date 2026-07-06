{ self, ... }: {
  flake.nixosModules.impermanence = { config, ... }: {
    imports = [
      self.nixosModules.impermanence-engine
    ];

    config = {
      persistence = {
        enable = true;
        nukeRoot.enable = true;
        user = config.preferences.user.name;
        volumeGroup = "btrfs_vg";

        directories = [];

        data.directories = [
          "Downloads"
          "Documents"
          "Pictures"
          "Videos"
          "surtasNixOS"
          ".ssh"
          ".config/noctalia"
          ".local/share/zoxide"
          ".zen"
          ".config/zen"
        ];

        data.files = [];
      };
    };
  };
}
