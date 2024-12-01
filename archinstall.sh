#!/bin/bash



# -------pre-install-------
# keyboard layout
#loadkeys de-latin1

# check if user has wifi
echo "Stell sicher dass du Internet hast!!!"

# hostname
echo "Wie soll der PC heißen?"
read HOSTNAME

# root password
ROOT_PASSWORD="0"
ROOT_PASSWORD2="1"

while [ "$ROOT_PASSWORD" != "$ROOT_PASSWORD2" ]
do
    echo "Welches Passwort soll der root-Account haben?"
    read ROOT_PASSWORD
    echo "Bitte gieb dass Passwort nochmal ein."
    read ROOT_PASSWORD2
done

# username
echo "Wie soll dein Benutzername sein?"
read USERNAME

# user password
USER_PASSWORD="0"
USER_PASSWORD2="1"

while [ "$USER_PASSWORD" != "$USER_PASSWORD2" ]
do
    echo "Welches Passwort soll der user-Account haben?"
    read USER_PASSWORD
    echo "Bitte gieb dass Passwort nochmal ein."
    read USER_PASSWORD2
done

# check completness
echo "
hostname: $HOSTNAME
root password: $ROOT_PASSWORD
username: $USERNAME
user password: $USER_PASSWORD

Stimmt dass?
wenn nicht beende das skript einfach,
bin zu faul da was einzuprogrammieren.
"
read _

# ------PARTITIONING------
#: '
DISK="/dev/sda"

echo "GPT Partition wird erstellt..."
echo -e "g\nw" | gdisk "$DISK"
echo "GPT wurde erstellt."

sleep 2

echo "EFI System-Partition wird erstellt..."
echo -e "n\n1\n\n+200M\nef00\nw" | gdisk "$DISK"  # 'n' for new partition, 'ef00' is EFI partition type
echo "EFI wurde erstellt."

sleep 2

echo "SWAP wird erstellt..."
echo -e "n\n2\n\n+4G\n8200\nw" | gdisk "$DISK"  # '8200' is Linux swap partition type
echo "SWAP wurde erstellt."

sleep 2

echo "ROOT wird erstellt..."
echo -e "n\n3\n\n\n8300\nw" | gdisk "$DISK"  # '8300' is Linux filesystem type
echo "ROOT wurde erstellt."

sleep 2

echo "Derzeitige DISK:"
gdisk -l "$DISK"
echo "DISK Partitioniert."
#'
