#!/bin/bash
# 'set -e' tells the script: "If any single command fails, stop immediately!"
# This prevents it from building a broken package if you make a typo.
set -e

# ==============================================================================
# STEP 1: READ METADATA DYNAMICALLY
# ==============================================================================
# Instead of you typing out the version number, the script looks inside your
# DEBIAN/control file, grabs the text after "Version:", and saves it to a variable.
VERSION=$(grep -E "^Version:" DEBIAN/control | awk '{print $2}')
PACKAGE_NAME="disk-guardian"
BUILD_DIR="${PACKAGE_NAME}_${VERSION}_all"

echo "Starting automated manufacturing pipeline for: ${BUILD_DIR}"

# ==============================================================================
# STEP 2: CLEAN SLATE
# ==============================================================================
# If an old, messy build folder from yesterday is sitting around, get rid of it.
# Then, create a fresh, clean staging folder named 'disk-guardian_1.0.0_all'.
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# ==============================================================================
# STEP 3: COPY INGREDIENTS INTO THE CONVEYOR BELT
# ==============================================================================
# This copies your clean, timeless folders into the temporary versioned directory.
echo "Staging source ingredients..."
cp -r DEBIAN "$BUILD_DIR/"
cp -r etc "$BUILD_DIR/"
cp -r usr "$BUILD_DIR/"

# ==============================================================================
# STEP 4: ENFORCE DIRECTORY SANITIZATION
# ==============================================================================
# It enforces permissions on the staging folder automatically so you don't have to.
chmod 755 "$BUILD_DIR/DEBIAN/postinst"
chmod -R g-w "$BUILD_DIR"

# ==============================================================================
# STEP 5: MANUFACTURE THE BUNDLE
# ==============================================================================
# It runs the exact compilation command you've been running manually,
# complete with the --root-owner-group flag so you never need sudo.
echo "Compiling Debian binary archive..."
dpkg-deb --build --root-owner-group "$BUILD_DIR"

# ==============================================================================
# STEP 6: VACUUM THE FACTORY FLOOR
# ==============================================================================
# Now that the 'disk-guardian_1.0.0_all.deb' file is successfully generated,
# we don't need the messy temporary folder anymore. This deletes it.
rm -rf "$BUILD_DIR"

echo "Success! Generated: ${BUILD_DIR}.deb"
echo "Your source tree remains perfectly clean and untracked by Git."
