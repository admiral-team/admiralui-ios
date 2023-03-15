#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."
DIR="$PWD"

ARCHIVE_ADMIRAL_SIMULATOR_PATH="$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive"
ARCHIVE_ADMIRAL_IPHONE_PATH="$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive"
ARCHIVE_SWIFTUI_SIMULATOR_PATH="$DIR/XCFrameworks/AdmiralSwiftUI-iphonesimulator.xcarchive"
ARCHIVE_SWIFTUI_IPHONE_PATH="$DIR/XCFrameworks/AdmiralSwiftUI-iphoneos.xcarchive"
PRODUCTS_PATH="/Products/Library/Frameworks/"

xcodebuild archive \
 -scheme AdmiralUIKit \
 -archivePath "$ARCHIVE_ADMIRAL_SIMULATOR_PATH" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
 
xcodebuild archive \
 -scheme AdmiralUIKit \
 -archivePath "$ARCHIVE_ADMIRAL_IPHONE_PATH" \
 -sdk iphoneos \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# Admiral UIKit
xcodebuild -create-xcframework \
 -framework "${ARCHIVE_ADMIRAL_SIMULATOR_PATH}${PRODUCTS_PATH}AdmiralUIKit.framework" \
 -framework "${ARCHIVE_ADMIRAL_IPHONE_PATH}${PRODUCTS_PATH}AdmiralUIKit.framework" \
 -output "$DIR/XCFrameworks/AdmiralUIKit.xcframework"

 xcodebuild -create-xcframework \
 -framework "${ARCHIVE_ADMIRAL_SIMULATOR_PATH}${PRODUCTS_PATH}AdmiralTheme.framework" \
 -framework "${ARCHIVE_ADMIRAL_IPHONE_PATH}${PRODUCTS_PATH}AdmiralTheme.framework" \
 -output "$DIR/XCFrameworks/AdmiralTheme.xcframework"

 xcodebuild -create-xcframework \
 -framework "${ARCHIVE_ADMIRAL_SIMULATOR_PATH}${PRODUCTS_PATH}AdmiralUIResources.framework" \
 -framework "${ARCHIVE_ADMIRAL_IPHONE_PATH}${PRODUCTS_PATH}AdmiralUIResources.framework" \
 -output "$DIR/XCFrameworks/AdmiralUIResources.xcframework"

  xcodebuild -create-xcframework \
 -framework "${ARCHIVE_ADMIRAL_SIMULATOR_PATH}${PRODUCTS_PATH}AdmiralCore.framework" \
 -framework "${ARCHIVE_ADMIRAL_IPHONE_PATH}${PRODUCTS_PATH}AdmiralCore.framework" \
 -output "$DIR/XCFrameworks/AdmiralCore.xcframework"

# Admiral SwiftUI
 xcodebuild archive \
 -scheme AdmiralSwiftUI \
 -archivePath "$ARCHIVE_SWIFTUI_SIMULATOR_PATH" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
 
xcodebuild archive \
 -scheme AdmiralSwiftUI \
 -archivePath "$ARCHIVE_SWIFTUI_IPHONE_PATH" \
 -sdk iphoneos \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
 -framework "${ARCHIVE_SWIFTUI_SIMULATOR_PATH}${PRODUCTS_PATH}AdmiralSwiftUI.framework" \
 -framework "${ARCHIVE_SWIFTUI_IPHONE_PATH}${PRODUCTS_PATH}AdmiralSwiftUI.framework" \
 -output "$DIR/XCFrameworks/AdmiralSwiftUI.xcframework"

rm -r "$ARCHIVE_ADMIRAL_SIMULATOR_PATH"
rm -r "$ARCHIVE_ADMIRAL_IPHONE_PATH"
rm -r "$ARCHIVE_SWIFTUI_SIMULATOR_PATH"
rm -r "$ARCHIVE_SWIFTUI_IPHONE_PATH"