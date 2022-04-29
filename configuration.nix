# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.device = "/dev/sde";

  networking = {
    hostName = "uge_server";
    interfaces.enp0s25 = {
      ipv4.addresses = [{
        address = "10.77.84.26";
        prefixLength = 26;
      }];
      useDHCP = true;
    };
    defaultGateway = {
      address = "10.77.84.1";
      interface = "enp0s25";
    };
    nameservers = [ "10.1.6.130" ];
  };
 
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  hardware.cpu.intel.updateMicrocode = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "br-abnt2";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "br";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  environment.systemPackages = with pkgs; [
     vim wget firefox htop ranger ntfs3g exfat 
  ];

  # Shell
  programs.bash.shellAliases = {
    nclear = "nix-collect-garbage -d";
    nconfig = "vim /etc/nixos/configuration.nix";
    nupdate = "nixos-rebuild switch";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce = {
    enable = true;
    thunarPlugins = [
      pkgs.xfce.thunar-archive-plugin
    ];
  };
 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

