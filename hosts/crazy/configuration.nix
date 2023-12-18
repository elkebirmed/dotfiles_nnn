# System's configuration file. (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings = {
      experimental-features = "nix-command flakes";
  };

  networking = {
      hostName = "crazy";
      networkmanager.enable = true;
      resolvconf.dnsExtensionMechanism = false;
      firewall.enable = false;
  };

  time.timeZone = "Africa/Algiers";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
    supportedLocales = [ "all" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  users.users.mohamed = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # enables sudo
      "networkmanager" # allow editing network connections without sudo
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    curl
    lf
  ];

  services.openssh.enable = true;

  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}