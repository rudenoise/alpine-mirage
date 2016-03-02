# Add user account
addgroup mirage
adduser -s /bin/bash -G mirage mirage
### NOTE: As is, this will prompt for a password.
###       Marked for a later update geared towards an unattended install.

# Configure the new account for sudo
sed -ri 's/(wheel:x:10:root)/\1,mirage/' /etc/group
sed -ri 's/# %wheel\tALL=\(ALL\) ALL/%wheel\tALL=\(ALL\) ALL/' /etc/sudoers
