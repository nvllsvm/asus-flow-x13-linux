# Arch Linux on Asus Flow X13
Fixes and tweaks for running Arch Linux on the Asus Flow X13 laptop.

#### Patching ACPI DSDT
```
sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.dat
iasl -d dsdt.dat
patch -u -b dsdt.dsl -i dsdt_bios_v407.dsl.patch
iasl -tc dsdt.dsl
mkdir -p kernel/firmware/acpi
mv dsdt.aml kernel/firmware/acpi
find kernel | cpio -H newc --create > asus_flow_x13_gv301qe_bios_v407_acpi_dsdt_s3_fix.img
sudo cp asus_flow_x13_gv301qe_bios_v407_acpi_dsdt_s3_fix.img /boot
```

Modify your systemd-boot loader entry with the override and mem_sleep_default option:
```
title	Arch Linux
linux	/vmlinuz-linux
initrd	/amd-ucode.img
initrd  /asus_flow_x13_gv301qe_bios_v407_acpi_dsdt_s3_fix.img
initrd	/initramfs-linux.img
options cryptdevice=UUID=d3a11ecd-44e8-4de6-81a3-cb3fe6cc7e8f:root:allow-discards root=/dev/mapper/root rw
options mem_sleep_default=deep
```
