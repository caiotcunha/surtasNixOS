{ inputs, ... }: {
  flake.nixosModules.impermanence-engine = { lib, config, ... }: let
    cfg = config.persistence;
  in {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    options.persistence = {
      enable = lib.mkEnableOption "";
      nukeRoot.enable = lib.mkEnableOption "";
      user = lib.mkOption { type = lib.types.str; default = "surtas"; };
      volumeGroup = lib.mkOption { type = lib.types.str; default = "btrfs_vg"; };

      directories = lib.mkOption { default = []; };
      files = lib.mkOption { default = []; };
      data.directories = lib.mkOption { default = []; };
      data.files = lib.mkOption { default = []; };
    };

    config = lib.mkIf cfg.enable {
      fileSystems."/persist".neededForBoot = true;
      programs.fuse.userAllowOther = true;
      boot.tmp.cleanOnBoot = lib.mkDefault true;

      environment.persistence."/persist/system" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          "/tmp"
        ] ++ cfg.directories;

        files = [ "/etc/machine-id" ] ++ cfg.files;
      };

      environment.persistence."/persist/userdata".users."${cfg.user}" = {
        directories = cfg.data.directories;
        files = cfg.data.files;
      };

      boot.initrd.postDeviceCommands = lib.mkIf cfg.nukeRoot.enable (lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/${cfg.volumeGroup}/root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '');
    };
  };
}
