{ ... }: {
  flake.wrappersModules.kitty = { config, lib, ... }: {
    
    options.shell = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    
    config = {
      args = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      
      settings = {

	hide_window_decorations = "yes";

        enable_audio_bell = "no";
        font_size = 14;
        font_family = "monospace";
        allow_remote_control = "yes";
        shell_integration = "enabled";
        cursor_trail = 0; 
        
        # EVA-01
        background = "#1f1c27";
        foreground = "#b6a0ff";
        cursor = "#ff9738";
        selection_background = "#353146";
        selection_foreground = "#1f1c27";
        
        dynamic_background_opacity = "yes";
        tab_bar_background = "none";
        tab_bar_margin_color = "none";
	active_tab_background = "#1f1c27";
        inactive_tab_background = "#1f1c27";

        # Cores do Sistema (ANSI)
        color0  = "#1f1c27";
        color8  = "#353146";
        color1  = "#d8393d";
        color9  = "#d8393d";
        color2  = "#2388ff";
        color10 = "#2388ff";
        color3  = "#d8b76e";
        color11 = "#d8b76e";
        color4  = "#ffc183";
        color12 = "#ffc183";
        color5  = "#dd8d40";
        color13 = "#dd8d40";
        color6  = "#83e68d";
        color14 = "#83e68d";
        color7  = "#b6a0ff";
        color15 = "#e9e4ff";
      };
    };
  };
}
