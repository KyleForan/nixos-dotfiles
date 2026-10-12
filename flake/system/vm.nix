{
  config,
  pkgs,
  ...
}: {
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  users.groups.libvirtd.members = ["default"];
  networking.firewall.trustedInterfaces = ["virbr0"];

  environment.systemPackages = with pkgs; [virt-viewer];
}
