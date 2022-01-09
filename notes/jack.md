Configure qjackctl to

- on start: autokill pulse and restart in bridged mode
- on kill: autokill pulse and restart in unbridged mode

https://forums.fedoraforum.org/showthread.php?284623-Disable-pulseaudio-and-start-jack

// TODO: add this configuration to system playbook.
// TODO: add qjackctl to system playbook
// sudo usermod -a -G audio ra

update memlock settings
https://askubuntu.com/questions/166126/unable-to-start-jack-cannot-allocate-memory
