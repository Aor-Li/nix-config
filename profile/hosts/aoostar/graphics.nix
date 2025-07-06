{ pkgs, lib, ... }:
{
  # Enable OpenGL/graphics hardware acceleration for Intel integrated graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Enable 32-bit support for compatibility

    # Intel-specific drivers
    extraPackages = with pkgs; [
      intel-media-driver # Intel VAAPI driver for newer GPUs (>=Gen 8)
      intel-vaapi-driver # Intel VAAPI driver for older GPUs
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # Intel NEO OpenCL runtime for compute workloads
      intel-ocl # Intel OpenCL runtime
    ];

    # 32-bit support for Intel drivers
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Enable firmware loading
  hardware.enableRedistributableFirmware = true;

  # Enable support for Intel integrated graphics
  boot.initrd.kernelModules = [ "i915" ];

  # Early KMS (Kernel Mode Setting) for Intel graphics
  boot.kernelParams = [
    "i915.enable_guc=3"  # Enable GuC and HuC firmware loading
    "i915.enable_psr=1"  # Enable Panel Self Refresh
  ];

  # Environment variables for hardware acceleration
  environment.sessionVariables = {
    # Intel VAAPI driver selection
    LIBVA_DRIVER_NAME = "iHD"; # Use iHD for newer Intel GPUs
    # Fallback to i965 if iHD doesn't work:
    # LIBVA_DRIVER_NAME = "i965";
  };
}
