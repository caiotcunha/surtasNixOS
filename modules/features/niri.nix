{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];

        hotkey-overlay = {
            skip-at-startup = {};
        };

	window-rules = [
          {
            matches = [
              { app-id = "kitty"; }
            ];
            opacity = 0.85;
            draw-border-with-background = false;
          }
        ];

	outputs = {	
	    "HDMI-A-1" = {
                mode = "1920x1080@74.973";
                position = _: { props = { x = 0; y = 0; }; };
            };

            "DP-1" = {
                mode = "2560x1440@143.973";
                position = _: { props = { x = 1920; y = 0; }; };
            };
	};

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.terminal;
          "Mod+Q".close-window = {};
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";

          "Mod+Left".focus-column-left = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Right".focus-column-right = {};

          "Mod+H".focus-column-left = {};
          "Mod+J".focus-window-down = {};
          "Mod+K".focus-window-up = {};
          "Mod+L".focus-column-right = {};

          "Mod+Shift+Left".move-column-left = {};
          "Mod+Shift+Down".move-window-down = {};
          "Mod+Shift+Up".move-window-up = {};
          "Mod+Shift+Right".move-column-right = {};

          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+J".move-window-down = {};
          "Mod+Shift+K".move-window-up = {};
          "Mod+Shift+L".move-column-right = {};

          "Mod+Home".focus-column-first = {};
          "Mod+End".focus-column-last = {};
          "Mod+Shift+Home".move-column-to-first = {};
          "Mod+Shift+End".move-column-to-last = {};
          
          "Mod+Page_Down".focus-workspace-down = {};
          "Mod+Page_Up".focus-workspace-up = {};
          "Mod+U".focus-workspace-down = {};
          "Mod+I".focus-workspace-up = {};

          "Mod+Shift+Page_Down".move-column-to-workspace-down = {};
          "Mod+Shift+Page_Up".move-column-to-workspace-up = {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = {};
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = {};

          "Mod+Comma".consume-window-into-column = {};
          "Mod+Period".expel-window-from-column = {};

          "Mod+R".switch-preset-column-width = {};
          "Mod+F".maximize-column = {};
          "Mod+Shift+F".fullscreen-window = {};
          "Mod+C".center-column = {};
          "Mod+Shift+C".toggle-window-floating = {};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Print".screenshot = {};
          "Ctrl+Print".screenshot-screen = {};
          "Alt+Print".screenshot-window = {};
          "Mod+Shift+E".quit = {};
        };
      };
    };
  };
}
