{
  config, 
  pkgs, 
  ... 
}: {

  services.tailscale.enable = true;
  
  # Issue https://github.com/tailscale/tailscale/issues/4432#issuecomment-1112819111
  networking.firewall.checkReversePath = "loose";

}