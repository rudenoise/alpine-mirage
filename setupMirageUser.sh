# Add user account
addgroup mirage
adduser -s /bin/bash -G mirage mirage

# Configure the new account for sudo
sed -ri 's/(wheel:x:10:root)/\1,mirage/' /etc/group
#sed -ri 's/# %wheel\tALL=\(ALL\) ALL/%wheel\tALL=\(ALL\) ALL/' /etc/sudoers
# do this via
# visudo
