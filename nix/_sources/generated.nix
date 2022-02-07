# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  airflow-latest = {
    pname = "airflow-latest";
    version = "471e368eacbcae1eedf9b7e1cb4290c385396ea9";
    src = fetchFromGitHub ({
      owner = "apache";
      repo = "airflow";
      rev = "471e368eacbcae1eedf9b7e1cb4290c385396ea9";
      fetchSubmodules = false;
      sha256 = "sha256-QR379lNof4nmGEEDt5Awz9XCBuPguVUPN76tsC2LgTQ=";
    });
  };
  airflow-release = {
    pname = "airflow-release";
    version = "2.2.3";
    src = fetchFromGitHub ({
      owner = "apache";
      repo = "airflow";
      rev = "2.2.3";
      fetchSubmodules = false;
      sha256 = "sha256-+Ae1Zo6h1DWHxm5Bu2s3zc7hN1tBF1yVwuQR6c9Xwws=";
    });
  };
  apache-airflow-providers-cncf-kubernetes = {
    pname = "apache-airflow-providers-cncf-kubernetes";
    version = "3.0.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/a/apache-airflow-providers-cncf-kubernetes/apache-airflow-providers-cncf-kubernetes-3.0.1.tar.gz";
      sha256 = "sha256-aIh9CO7LuocJTELscekExvPk9lJmujm7tfWNQ5Ky3oQ=";
    };
  };
  apache-airflow-providers-ftp = {
    pname = "apache-airflow-providers-ftp";
    version = "2.0.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/a/apache-airflow-providers-ftp/apache-airflow-providers-ftp-2.0.1.tar.gz";
      sha256 = "sha256-xPWy+mG64/QoG8wLjCwp7agaIQegCq/VB4Hzlf6t0VY=";
    };
  };
  apache-airflow-providers-http = {
    pname = "apache-airflow-providers-http";
    version = "2.0.2";
    src = fetchurl {
      url = "https://pypi.io/packages/source/a/apache-airflow-providers-http/apache-airflow-providers-http-2.0.2.tar.gz";
      sha256 = "sha256-SSfekEX6LPXS8AeQcHz0PJqNAyyNbfz3EmkJ/LHjPbQ=";
    };
  };
  apache-airflow-providers-imap = {
    pname = "apache-airflow-providers-imap";
    version = "2.1.0";
    src = fetchurl {
      url = "https://pypi.io/packages/source/a/apache-airflow-providers-imap/apache-airflow-providers-imap-2.1.0.tar.gz";
      sha256 = "sha256-e7gVGS5cvZwg0aEutscfg2Lkm7Nm9mCmOJNfQUsrqU8=";
    };
  };
  apache-airflow-providers-sqlite = {
    pname = "apache-airflow-providers-sqlite";
    version = "2.0.1";
    src = fetchurl {
      url = "https://pypi.io/packages/source/a/apache-airflow-providers-sqlite/apache-airflow-providers-sqlite-2.0.1.tar.gz";
      sha256 = "sha256-mpkeEPi3vEAo/zs4nygGB+BkI/l9QyexNjg+alLZ/Pk=";
    };
  };
}
