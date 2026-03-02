{
  flake.modules.nixos.intel =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
