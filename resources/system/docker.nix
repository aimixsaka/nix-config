{
  # Enable docker on btrfs
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # rootless
  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};
}
