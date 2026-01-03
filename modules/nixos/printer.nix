{
  config,
  pkgs,
  ...
}: {
  services.printing.enable = true;
  
  # Avahi for auto detect LAN printers
  #services.avahi = {
  #  enable = true;
  #  nssmdns4 = true;
  #  # Allow Avahi in firewall
  #  #openFirewall = true;
  #};
  # Or allow Avahi only in your LAN network
  #networking.firewall.extraCommands = ''
  #  nft add rule inet filter input udp dport 5353 ip saddr LAN_NETWORK/24 accept
  #  nft add rule inet filter input udp dport 5353 drop
  #'';

  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

}
