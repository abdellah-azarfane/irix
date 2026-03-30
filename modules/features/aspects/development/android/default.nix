{
 flake.nixosModules.android = { pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    android-tools
    android-studio
    qtscrcpy
    scrcpy
    openjdk17
    android-studio-tools
    android-file-transfer
    android-backup-extractor
    gradle
    maven
    protobuf
  ];
  };
}