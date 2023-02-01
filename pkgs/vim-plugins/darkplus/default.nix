{ vimUtils, fetchFromGitHub }: vimUtils.buildVimPlugin {
  pname = "darkplus";
  version = "2023-01-31";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "LunarVim";
    repo = "darkplus.nvim";
    rev = "1826879d9cb14e5d93cd142d19f02b23840408a6";
    sha256 = "sha256-/e7PCA931t5j0dlvfZm04dQ7dvcCL/ek+BIe1zQj5p4=";
  };
  meta.homepage = "https://github.com/LunarVim/darkplus.nvim";
}
