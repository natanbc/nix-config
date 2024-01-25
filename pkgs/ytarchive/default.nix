{ buildGoModule, fetchFromGitHub, ffmpeg, makeWrapper }:

buildGoModule rec {
    pname = "ytarchive";
    version = "5d91faa";

    src = fetchFromGitHub {
        owner = "Kethsar";
        repo = "${pname}";
        rev = "5d91faa0dd15b9844af6764c627927730e175d77";
        hash = "sha256-RoPFN8ZLXd+bq1cqtLG+7bQcj0oT5Q132ytJ9gsw1W0=";
    };

    patches = [ ./retry.patch ];

    vendorHash = "sha256-sjwQ/zEYJRkeWUDB7TzV8z+kET8lVRnQkXYbZbcUeHY=";

    nativeBuildInputs = [ makeWrapper ];

    postInstall = ''
      wrapProgram $out/bin/ytarchive --prefix PATH : "${ffmpeg}/bin"
    '';
}

