{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.clipit;
  package = pkgs.clipit;

in {
  meta.maintainers = [ ];

  options = { services.clipit = { enable = mkEnableOption "Clipit"; }; };

  config = mkIf cfg.enable {
    home.packages = [ package ];

    systemd.user.services.clipit = {
      Unit = {
        Description = "Lightweight GTK+ clipboard manager";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        ExecStart = "${package}/bin/clipit";
        Restart = "on-abort";
      };
    };
  };
}
