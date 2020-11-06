{ stdenv
, python3Packages
, python3
, lib
, callPackage
}:
with python3.pkgs;
let
  apache_airflow_static = callPackage ./static.nix {};

  flakeLock = lib.importJSON ./flake.lock;
  loadInput = { locked, ... }:
    assert locked.type == "github";
    builtins.fetchTarball {
      url = "https://github.com/${locked.owner}/${locked.repo}/archive/${locked.rev}.tar.gz";
      sha256 = locked.narHash;
    };

  src = loadInput flakeLock.nodes.airflow;

  apache_airflow_dep = import ./nix/python.nix;

  python-nvd3 = python3Packages.buildPythonPackage rec {
    pname = "python-nvd3";
    version = "0.15.0";
    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-+9df9H4O8lW0qk86ixDci0Akqlqaer7VskBr08uBdxU=";
    };
    doCheck = false;
    propagatedBuildInputs = with python3Packages; [ apache_airflow_dep ];
  };

in
python3Packages.buildPythonPackage rec {
  pname = "apache-airflow";
  version = "2.0.0a1";

  inherit src;

  doCheck = false;

  propagatedBuildInputs = with python3Packages; [ apache_airflow_dep
                                                  python-nvd3
                                                ];

  postPatch = ''
    cp -r ${apache_airflow_static}/dist airflow/www/static
    substituteInPlace setup.py \
      --replace "python-daemon>=2.1.1, <2.2" "python-daemon" \
      --replace "dill>=0.2.2, <0.3" "dill" \
      --replace "attrs~=19.3" "attrs" \
      --replace "cattrs~=1.0" "cattrs" \
      --replace "configparser>=3.5.0, <3.6.0" "configparser" \
      --replace "werkzeug<1.1.0" "werkzeug" \
      --replace "future>=0.16.0, <0.17" "future" \
      --replace "flask-appbuilder>=1.12.5, <2.0.0" "flask-appbuilder" \
      --replace "flask-admin==1.5.3" "flask-admin" \
      --replace "flask-swagger==0.2.13" "flask-swagger" \
      --replace "dumb-init>=1.2.2" "" \
      --replace "tzlocal>=1.4,<2.0.0" "tzlocal" \
      --replace "funcsigs==1.0.0" "funcsigs" \
      --replace "pandas>=0.17.1, <1.0.0" "pandas" \
      --replace "text-unidecode==1.2" "text-unidecode" \
      --replace "jinja2>=2.10.1, <2.11.0" "jinja2"

      # substituteInPlace airflow/www/webpack.config.js \
      # --replace "./static/dist" "${apache_airflow_static}/dist" \
      # --replace "./static" "${apache_airflow_static}"


      #  substituteInPlace airflow/www/extensions/init_manifest_files.py \
      # --replace "static/dist/manifest.json" "${apache_airflow_static}/dist/manifest.json"

      '';

  makeWrapperArgs = [ "--prefix PYTHONPATH : $PYTHONPATH" ];
}
