{ self, inputs, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.desktop
      self.nixosModules.desktopConfiguration
    ];
  };
}
