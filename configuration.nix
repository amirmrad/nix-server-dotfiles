 { pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   time.timeZone = "Europe/London";
   i18n.defaultLocale = "en_US.UTF-8";
   console.keyMap = "us";
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     username = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
         "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzv/7dMRN7F568vtxB3fZ1xBEuAjCNu4ajB1saPjcj4QWjjOKQpGXTtjhU9u/6DmPUQKkW4e2YznH9Al9qRBHvEsqaumcQymkCDrtSzd8XD5/uccLgId6XQMF84+H9XXY9tQ8ouDHkKZdHpE/7pLLB4/1zVyu45uIDmJczwRGP5+ZhqjaUdUkfCnVKLVL0Rzzs39bMmOC05g3FerXYWxP+9FOAzx1Y60lwDJv4noim66feEuOaAWd2jxZJm6bKw9voIgLwEd8VUPzBWg3wOiB1curKj+T29S3BwNnM+RcX35ll8SYRegUaumt/zJShVws0piNa45Kwx6VlDZsHmRyrJqDnpbpvbspdBZ1Z5eU+/Fb52wCmZ9rgD6f5WHdhU7xcTz2CP9Gis2kZUmbetV1K6zjwfxb7N9pwU0vyx0a3V00o3ka3YdlUW6ifva95W424UMuUZbSckTKW+nJTcT4jtZLXNFlAr8ezky1Y+Iqt6OHKxpIhtd8u5Dpi33WmVb8= amir@unity"
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };
   
   networking.firewall.allowedTCPPorts = [ 22 ];
   
   system.stateVersion = "24.11";
 }
