# overlays/mvfst-git.nix
final: prev: {
  mvfst = prev.mvfst.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "facebook";
      repo = "mvfst";

      # pick ONE:
      rev = "v2025.10.27.00"; # tag OR commit hash

      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
  });
}
