#!/usr/bin/env bash
apk update
apk upgrade
setup-apkrepos -o
# x11
apk add xorg-server xf86-input-libinput eudev eudev-openrc mesa-dri-gallium \
    mesa mesa-gl mesa-utils mesa-osmesa mesa-egl mesa-gles mesa-va-gallium \
    libva-intel-driver intel-media-driver xf86-video-intel libva-intel-driver \
    intel-media-driver xf86-video-amdgpu xf86-video-nouveau xf86-video-ati \
    xf86-input-evdev xf86-video-modesetting
# kde
apk add plasma-desktop systemsettings sddm breeze okular
apk add ark dolphin konsole spectacle
# apps
apk add nano librewolf ca-certificates 
# logind and other stuff
apk add elogind polkit-elogind dbus wpa_supplicant networkmanager \
    bluez networkmanager-wifi networkmanager-tui librsvg fuse \
    acpi acpid acpid-openrc alpine-conf zram-init acpi-utils \
    bluez bluez-deprecated bluez-openrc
# pipewire
apk add wireplumber pipewire pipewire-pulse pipewire-alsa pipewire-spa-bluez \
    pipewire-jack pipewire-spa-tools
# remove baloo_file at startup
rm -f /etc/xdg/autostart/baloo_file.desktop
echo -e "live\nlive\n" | passwd root
rc-update add acpid
rc-update add dbus
rc-update add bluetooth
rc-update add networkmanager
rc-update add wpa_supplicant
rc-update add sddm
rc-update add udev
rc-update add elogind
rc-update add fuse
# laptop stuff
apk add acpi cpufreqd pm-utils
rc-update add cpufreqd
# i915 stuff
cat > /etc/modprobe.d/i915.conf <<EOF
options i915 enable_rc6=1
options i915 enable_psr=1
options i915 enable_guc=2
options i915 enable_fbc=1
EOF

setup-devd udev
