{ fetchPypi, yt-dlp, ... }:

yt-dlp.overrideAttrs (rec {
  version = "2025.3.26";
  src = fetchPypi {
    inherit version;
    pname = "yt_dlp";
    hash = "sha256-R0Vhcrx6iNuhxRn+QtgAh6j1MMA9LL8k4GCkH48fbss=";
  };
})

