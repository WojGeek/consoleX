#!/bin/sh



enable_alias_apt() {
    
    # apt -  Debian/Ubuntu derivates
    alias show_apt_alias='echo -e "Alias for apt:
    • apki - install
    • apks - search
    • apkr - remove
    • apkq - info
    • apku - update "'
    alias apki='sudo apt install -y "$@"'
    alias apks='apt search "$@"'
    alias apkr='sudo apt remove'
    alias apkq='apt show "$@" '
    alias apku='sudo apt update'
}

enable_alias_dnf() {
    
    # dnf - RHEL Derivates, Fedora, AlmaLinux, Rocky Linux / RPM-based Linux distributions.
    alias show_dnf_alias='echo -e "Alias for dnf/yum:
    • dnfi - install
    • dnfs - search
    • dnfr - remove
    • dnfq - info
    • dnfu - update "'
    
    alias dnfi='sudo dnf install "$@"'
    alias dnfs='sudo dnf search "$@"'
    alias dnfr='sudo dnf remove "$@"'
    alias dnfu='sudo dnf update "$@"'
    alias dnfq='sudo dnf info "$@"'
    
}

enable_alias_pkg_mgmt() {
    # Run all once
    enable_alias_dnf
    enable_alias_apt
    echo -e "\n- Packages management, run: show_dnf_alias | show_apt_alias "
}