#!/bin/sh

#
# Copyright (C) 2019 High-Mobility GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http:#www.gnu.org/licenses/.
#
# Please inquire about commercial licensing options at
# licensing@high-mobility.com
#
#  XCodeFrameworkBuilder.sh
#
#  Created by Mikk Rätsep on 12/09/2019.
#  Copyright © 2019 High-Mobility. All rights reserved.


######################
# Setup
######################

if [ -z "${SRCROOT}" ]; then
    SRCROOT="$( cd "$(dirname "$0")" ; pwd -P )/.."
fi


NAME=$(ls -1d *.xcodeproj | tail -n 1 | cut -f1 -d ".")

BUILD_DIR="${SRCROOT}/build"
BUILD_DIR_iphoneos="${BUILD_DIR}/iphoneos"
BUILD_DIR_iphonesimulator="${BUILD_DIR}/iphonesimulator"

FINAL_OUTPUT="${SRCROOT}/${NAME}.xcframework"
XCFRAMEWORK_OUTPUT="${BUILD_DIR}/${NAME}.xcframework"

# Remove the "old" build dir
echo "Cleaning previous build products..."
rm -rf $BUILD_DIR
mkdir $BUILD_DIR


######################
# Build
######################

# Archive for iOS
echo "Archiving device..."
xcodebuild archive \
    -project ${NAME}.xcodeproj \
    -scheme ${NAME} \
    -archivePath "${BUILD_DIR_iphoneos}/${NAME}.xcarchive" \
    -derivedDataPath "${BUILD_DIR_iphoneos}/Derived Data" \
    -sdk iphoneos \
    -destination "generic/platform=iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
#    -quiet

# Archive for simulator
echo "Archiving simulator..."
xcodebuild archive \
    -project ${NAME}.xcodeproj \
    -scheme ${NAME} \
    -archivePath "${BUILD_DIR_iphonesimulator}/${NAME}.xcarchive" \
    -derivedDataPath "${BUILD_DIR_iphonesimulator}/Derived Data" \
    -sdk iphonesimulator \
    -destination "generic/platform=iOS Simulator"
    SKIP_INSTALL=NO \
    BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
#    -quiet

# Build xcframework with two archives
echo "Creating XCFramework..."
xcodebuild -create-xcframework \
    -framework "${BUILD_DIR_iphoneos}/${NAME}.xcarchive/Products/Library/Frameworks/${NAME}.framework" \
    -framework "${BUILD_DIR_iphonesimulator}/${NAME}.xcarchive/Products/Library/Frameworks/${NAME}.framework" \
    -output ${XCFRAMEWORK_OUTPUT}


######################
# Move the product
######################

# Copy the Universal to the root dir
echo "Copying XCFramework..."
rm -rf "${FINAL_OUTPUT}"
cp -f -R "${XCFRAMEWORK_OUTPUT}" "${FINAL_OUTPUT}"


######################
# "Fix" the CFBundleVersion being missing
######################

echo "Updating .plists..."
for PLIST in $(ls -d "${FINAL_OUTPUT}"/*/"${NAME}".framework/Info.plist)
do
    VERSION=$(/usr/libexec/PlistBuddy -c "print :CFBundleShortVersionString" $PLIST)

    (/usr/libexec/PlistBuddy -c "add :CFBundleVersion string ${VERSION}" $PLIST)
done


######################
# Cleanup
######################

# Removes the "build/" folder from the source folder
echo "Removing build directory..."
rm -rfd "${SRCROOT}/build"
