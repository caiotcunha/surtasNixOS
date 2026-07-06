{
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    ...
  }: let
    fishConf =
      pkgs.writeText "fishy-fishy"
      # fish
      ''
        function fish_prompt
            string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) ']' (set_color normal) "\$ "
        end

        set fish_greeting
        fish_vi_key_bindings
      '';
  in {
    packages.fish = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fish;
      flags = {
        "-C" = "source ${fishConf}";
      };
    };
  };
}
