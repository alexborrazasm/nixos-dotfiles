{
  config,
  pkgs,
  ...
}: {

  boot.extraModulePackages = [ pkgs.xe-sriov ];
  
  boot.kernelParams = [ 
    "module_blacklist=i915"
    "xe.force_probe=46b3"
  ];
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva
      vpl-gpu-rt
      libvdpau-va-gl
    ];
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    nvtopPackages.intel # nvtop
  ];
  
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

}
