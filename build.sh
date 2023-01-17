#! /bin/bash

PROJECT_NAME=Kaasa.Mds.iOS
BUILD_FOLDER=$PROJECT_NAME/build
PROJECT=$PROJECT_NAME.csproj

XCODE_BUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
SHARPIE_OUTPUT_FOLDER=$PROJECT_NAME/SharpieGenerated
MDS_PROJECT=movesense-mobile-lib/IOS/MovesenseApi/MovesenseApi.xcodeproj
MDS_FRAMEWORK=movesense-mobile-lib/IOS/MovesenseApi/build/Release-iphoneos/MovesenseApi.framework

rm -rf $PROJECT_NAME/bin
rm -rf $PROJECT_NAME/obj
rm -rf $BUILD_FOLDER
mkdir -p $BUILD_FOLDER

$XCODE_BUILD ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO -project $MDS_PROJECT -configuration Release -sdk iphoneos build

sharpie bind -sdk iphoneos -o $SHARPIE_OUTPUT_FOLDER -n $PROJECT_NAME -f $MDS_FRAMEWORK

dotnet build $PROJECT_NAME/$PROJECT -c Release