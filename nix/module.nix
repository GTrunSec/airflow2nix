{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.airflow;
  airflowCmd = "${cfg.package}/bin/airflow";
in
{
  options =
    {
      services.airflow = {
        enable = mkEnableOption "airflow daemon";

        path = mkOption {
          type = types.path;
          default = "/var/lib/airflow";
          defaultText =
            literalExample ''"''${config.home.homeDirectory}/airflow"'';
          apply = toString;
          description = "Where to put the airflow directory.";
        };
        package = mkOption {
          type = types.package;
          default = pkgs.airflow-release;
        };
        port = mkOption {
          type = types.int;
          default = 8888;
          description = "Where the airflow port number";
        };
        ip = mkOption {
          type = types.str;
          default = "127.0.0.1";
          description = "Where the airflow ip address";
        };
      };
    };

  config = mkIf cfg.enable
    {
      environment.systemPackages = [ pkgs.airflow-release ];

      users.users.airflow = { isSystemUser = true; group = "airflow"; };
      users.groups.airflow = { };

      systemd.services.airflow = {
        description = "airflow Daemon";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        environment = {
          HOME = "${cfg.path}";
        };
        script = ''
          if [[ ! -d ${cfg.path}/airflow.cfg ]]; then
          ${airflowCmd} db init
          fi
          ${airflowCmd} webserver -p ${toString cfg.port} -H ${cfg.ip}
        '';
        serviceConfig = {
          Type = "simple";
          Restart = "on-failure";
          PrivateTmp = true;
          WorkingDirectory = "${cfg.path}";
          ReadWritePaths = "${cfg.path}";
          RuntimeDirectory = "airflow";
          CacheDirectory = "airflow";
          StateDirectory = "airflow";
          ProtectSystem = "full";
          Nice = 10;
          ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
          ExecStop = "${airflowCmd} stop";
        };
      };
    };
}
