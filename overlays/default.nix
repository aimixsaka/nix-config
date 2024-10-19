{
  self,
  inputs,
  system,
  ...
}:

{
  flake.overlays = {
    fcitx5-rime = import ./fcitx5;
    emacs-overlays = inputs.emacs-overlays.overlays.default;

    emacs-macport-overlay = self: super: {
      emacs-macport = inputs.pkgs-emacs-macport.legacyPackages.${system}.emacs-macport;
    };

    default =
      let
        overlays = [
          self.overlays.emacs-overlays
          self.overlays.emacs-macport-overlay
          self.overlays.fcitx5-rime
        ];
      in
      (self: super: super.lib.composeManyExtensions overlays self super);
  };
}
