#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"
cd ".."
DIR="$PWD"

xcodebuild archive \
 -scheme AdmiralUIKit \
 -archivePath "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
 
xcodebuild archive \
 -scheme AdmiralUIKit \
 -archivePath "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive" \
 -sdk iphoneos \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# Admiral UIKit
xcodebuild -create-xcframework \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive/Products/Library/Frameworks/AdmiralUIKit.framework" \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive/Products/Library/Frameworks/AdmiralUIKit.framework" \
 -output "$DIR/XCFrameworks/AdmiralUIKit.xcframework"

 xcodebuild -create-xcframework \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive/Products/Library/Frameworks/AdmiralTheme.framework" \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive/Products/Library/Frameworks/AdmiralTheme.framework" \
 -output "$DIR/XCFrameworks/AdmiralTheme.xcframework"

 xcodebuild -create-xcframework \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive/Products/Library/Frameworks/AdmiralUIResources.framework" \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive/Products/Library/Frameworks/AdmiralUIResources.framework" \
 -output "$DIR/XCFrameworks/AdmiralUIResources.xcframework"

  xcodebuild -create-xcframework \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive/Products/Library/Frameworks/AdmiralCore.framework" \
 -framework "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive/Products/Library/Frameworks/AdmiralCore.framework" \
 -output "$DIR/XCFrameworks/AdmiralCore.xcframework"

# Admiral SwiftUI
 xcodebuild archive \
 -scheme AdmiralSwiftUI \
 -archivePath "$DIR/XCFrameworks/AdmiralSwiftUI-iphonesimulator.xcarchive" \
 -sdk iphonesimulator \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
 
xcodebuild archive \
 -scheme AdmiralSwiftUI \
 -archivePath "$DIR/XCFrameworks/AdmiralSwiftUI-iphoneos.xcarchive" \
 -sdk iphoneos \
 SKIP_INSTALL=NO \
 BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
 -framework "$DIR/XCFrameworks/AdmiralSwiftUI-iphonesimulator.xcarchive/Products/Library/Frameworks/AdmiralSwiftUI.framework" \
 -framework "$DIR/XCFrameworks/AdmiralSwiftUI-iphoneos.xcarchive/Products/Library/Frameworks/AdmiralSwiftUI.framework" \
 -output "$DIR/XCFrameworks/AdmiralSwiftUI.xcframework"

rm -r "$DIR/XCFrameworks/AdmiralSwiftUI-iphonesimulator.xcarchive"
rm -r "$DIR/XCFrameworks/AdmiralSwiftUI-iphoneos.xcarchive"
rm -r "$DIR/XCFrameworks/AdmiralUI-iphonesimulator.xcarchive"
rm -r "$DIR/XCFrameworks/AdmiralUI-iphoneos.xcarchive"