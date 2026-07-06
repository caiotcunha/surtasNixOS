{ ... }: {
  flake.nixosModules.performance = { pkgs, ... }: {
    
    powerManagement.cpuFreqGovernor = "performance";

    services.thermald.enable = true;

    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
  };
}
