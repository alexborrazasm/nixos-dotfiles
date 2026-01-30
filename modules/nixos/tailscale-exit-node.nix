{
  config, 
  pkgs, 
  ... 
}: {
  # Enable tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  systemd.services.tailscale-udp-optimizations = {
    description = "Fix Tailscale UDP GRO forwarding";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      sleep 2
      NETDEV=$(${pkgs.iproute2}/bin/ip -o route get 8.8.8.8 | ${pkgs.gawk}/bin/awk '{print $5}')
      ${pkgs.ethtool}/bin/ethtool -K "$NETDEV" rx-udp-gro-forwarding on rx-gro-list off || true
    '';
  };

  environment.systemPackages = with pkgs; [
    ethtool
  ];

}
