Place your generated `hardware-configuration.nix` file in this folder.
Do not use the included configuration, it will not fit your setup.

Use the command below to generate your personal configuration
(make sure your drives are formatted and mounted).
```bash
nixos-generate-config --show-hardware-config > ./system-profiles/<profile_name>/hardware-configuration.nix
```