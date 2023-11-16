{ inputs, cell }:
let
  l = nixpkgs.lib // builtins;
  inherit (inputs) nixpkgs std;
in
l.mapAttrs (_: std.lib.dev.mkShell) {
  default =
    { ... }:
    {
      name = "dataflow2nix";

      imports = [
        inputs.std.std.devshellProfiles.default
        # inputs.cells.tullia.devshellProfiles.default
      ];

      packages = [ nixpkgs.poetry ];
      nixago =
        [
          # cell.nixago.mdbook
          cell.nixago.treefmt.default
        ];
      commands =
        [
          { package = nixpkgs.nsjail; }
          # {
          #   package = inputs.arion.packages.${nixpkgs.system}.arion;
          # }
        ]
        ++ (map
          (x: {
            name = "nvfetcher-${x}";
            command = ''
              nix develop github:GTrunSec/std-ext#update \
              --refresh --command \
              nvfetcher-update nix/${x}/packages/sources.toml
            '';
            help = "update ${x} toolchain with nvfetcher";
          })
          [
            "airflow"
            "prefect"
            "malloy"
            "skypilot"
            "kedro"
            "enso"
            "iterative"
            "sartography"
          ]
        );
    };
  tullia = {
    imports = [ inputs.cells.tullia.devshellProfiles.default ];
  };
  dev = {
    imports = [ inputs.cells.sartography.devshellProfiles.default ];
  };
}
