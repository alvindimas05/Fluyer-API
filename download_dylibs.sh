#!/bin/bash

# Define URLs and target directory
# universal | arm64 | x86_64
ARCH="universal"
BASE_URL="https://iina.io/dylibs/$ARCH"
FILELIST_URL="$BASE_URL/filelist.txt"
TARGET_DIR="macos-libs-$ARCH"
PARALLEL_AMOUNT=8

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download the filelist
curl -s "$FILELIST_URL" -o /tmp/filelist.txt

# Parallel download using xargs
cat /tmp/filelist.txt | grep -v '^$' | xargs -P $PARALLEL_AMOUNT -I {} bash -c \
  "echo 'Downloading {}...' && curl -s '$BASE_URL/{}' -o '$TARGET_DIR/{}'"

echo "All files downloaded to $TARGET_DIR"
