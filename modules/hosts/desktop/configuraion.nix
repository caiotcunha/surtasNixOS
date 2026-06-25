{ self, inputs, ... }: {

  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.desktopHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # paste config generated here
}
