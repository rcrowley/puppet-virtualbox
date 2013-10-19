class virtualbox($version = "4.3.0", $build = "89960", $prefix = "/usr/local") {

    exec {
        ["/usr/bin/curl -o $prefix/lib/vbox-tftpboot/arch/archiso.img http://ftp.osuosl.org/pub/archlinux/iso/latest/arch/boot/x86_64/archiso.img",
         "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/arch/pxelinux.0 https://releng.archlinux.org/pxeboot/boot/pxelinux.0",
         "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/arch/vmlinuz http://ftp.osuosl.org/pub/archlinux/iso/latest/arch/boot/x86_64/vmlinuz",
         "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/arch/vesamenu.c32 https://releng.archlinux.org/pxeboot/boot/vesamenu.c32"]:
            require => File["$prefix/lib/vbox-tftpboot/arch"];
        "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/boot-screens/vesamenu.c32 http://archive.ubuntu.com/ubuntu/dists/precise-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/boot-screens/vesamenu.c32":
            require => File["$prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/boot-screens"];
        ["/usr/bin/curl -o $prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/initrd.gz http://archive.ubuntu.com/ubuntu/dists/precise-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/initrd.gz",
        "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/linux http://archive.ubuntu.com/ubuntu/dists/precise-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/linux",
        "/usr/bin/curl -o $prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/pxelinux.0 http://archive.ubuntu.com/ubuntu/dists/precise-updates/main/installer-amd64/current/images/netboot/ubuntu-installer/amd64/pxelinux.0"]:
            require => File["$prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64"];
    }

    File {
        ensure => file,
        group => "wheel",
        owner => "root",
    }
    file {
        "/etc/paths":
            mode => 0644,
            source => "puppet:///modules/virtualbox/etc/paths";
        "$prefix":
            ensure => directory,
            group => undef,
            mode => 0755,
            owner => undef;
        ["$prefix/bin", "$prefix/lib"]:
            ensure => directory,
            group => undef,
            mode => 0775,
            owner => undef;
        "$prefix/bin/ssh":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/ssh";
        "$prefix/bin/vbox":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox";
        "$prefix/bin/vbox-down":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox-down";
        "$prefix/bin/vbox-restore":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox-restore";
        "$prefix/bin/vbox-save":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox-save";
        "$prefix/bin/vbox-snapshot":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox-snapshot";
        "$prefix/bin/vbox-up":
            mode => 0755,
            source => "puppet:///modules/virtualbox/bin/vbox-up";
        "$prefix/lib/vbox-preseed":
            ensure => directory,
            mode => 0755;
        "$prefix/lib/vbox-preseed/late_command.sh":
            mode => 0644,
            source => "puppet:///modules/virtualbox/lib/vbox-preseed/late_command.sh";
        "$prefix/lib/vbox-preseed/precise.seed":
            content => template("virtualbox/precise.seed.erb"),
            mode => 0644;
        "$prefix/lib/vbox-preseed.rb":
            mode => 0644,
            source => "puppet:///modules/virtualbox/lib/vbox-preseed.rb";
        ["$prefix/lib/vbox-tftpboot",
         "$prefix/lib/vbox-tftpboot/arch",
         "$prefix/lib/vbox-tftpboot/arch/pxelinux.cfg",
         "$prefix/lib/vbox-tftpboot/ubuntu",
         "$prefix/lib/vbox-tftpboot/ubuntu/pxelinux.cfg",
         "$prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer",
         "$prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64",
         "$prefix/lib/vbox-tftpboot/ubuntu/ubuntu-installer/amd64/boot-screens"]:
            ensure => directory,
            mode => 0755;
        "$prefix/lib/vbox-tftpboot/arch/pxelinux.cfg/default":
            content => template("virtualbox/arch-pxelinux.cfg-default.erb"),
            mode => 0644;

        # Clean up the old layout.
        ["$prefix/lib/vbox-tftpboot/pxelinux.0",
         "$prefix/lib/vbox-tftpboot/ubuntu-installer"]:
            ensure => absent,
            force => true,
            recurse => true;

        "$prefix/lib/vbox-tftpboot/ubuntu/pxelinux.0":
            ensure => link,
            target => "ubuntu-installer/amd64/pxelinux.0";
        "$prefix/lib/vbox-tftpboot/ubuntu/pxelinux.cfg/default":
            content => template("virtualbox/ubuntu-pxelinux.cfg-default.erb"),
            mode => 0644;
    }

    package { "VirtualBox-${version}-${build}-OSX.dmg":
        ensure => installed,
        provider => "pkgdmg",
        source => "http://dlc.sun.com.edgesuite.net/virtualbox/${version}/VirtualBox-${version}-${build}-OSX.dmg",
    }

}
