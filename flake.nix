{
  description = "A toolbox to benchmark workloads for TiDB";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule rec {
          pname = "go-tpc";
          version = "1.0.10";

          src = pkgs.fetchFromGitHub {
            owner = "pingcap";
            repo = "go-tpc";
            rev = "v${version}";
            sha256 = "sha256-O2Z5fqL2OIdASlKRwQxYCbftaA3dZMB30zOm2niwBGI=";
          };

          vendorHash = "sha256-JInXHnHW5jfKism5OscYSJJjBBB7URYLSVpo4EJ/HAs=";

          meta = with pkgs.lib; {
            description = "A toolbox to benchmark workloads for TiDB";
            homepage = "https://github.com/pingcap/go-tpc";
            license = licenses.asl20;
            maintainers = with maintainers; [ ];
            mainProgram = "go-tpc";
          };
        };
      }
    );
}