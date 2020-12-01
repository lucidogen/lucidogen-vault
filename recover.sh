#!/usr/bin/env bash

set -e
set -v

$KEYID="5C04328CDD4470B0"
echo "Recover '$KEYID' from exported keys."

# Install gpg
brew install gnupg
# Import public key
gpg --import /Volumes/LucidKey/public.asc
# Import private key
gpg --import /Volumes/LucidKey/private.asc
# Trust key
expect -c "spawn gpg --edit-key $KEYID trust quit; send \"5\ry\r\"; expect eof"
# Decrypt Lucidogen vault
gpg -d Lucidogen.kdbx.gpg > Lucidogen.kdbx
# Open vault with MacPass
open Lucidogen.kdbx