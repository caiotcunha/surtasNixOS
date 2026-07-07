{ self, inputs, ... }: {
  flake.nixosModules.preservation = { config, lib, ... }: {
    imports = [
      inputs.preservation.nixosModules.preservation
    ];

    fileSystems."/persist".neededForBoot = true;
    
    programs.fuse.userAllowOther = true;

    preservation.preserveAt."/persist" = {
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/tmp"
      ];
      
      files = [ 
        "/etc/machine-id" 
      ];

      users."surtas" = {
        directories = [
          "Downloads"
          "Documents"
          "surtasNixOS"
          ".ssh"
          ".config/noctalia"
          ".local/share/zoxide"
          ".zen"
          ".config/zen"
        ];
      };
    };
  };
}
