#! /bin/bash

PROJECT_NAME=Kaasa.Mds.iOS
BUILD_FOLDER=$PROJECT_NAME/build
NET_PROJECT=$PROJECT_NAME.NET.csproj
XAMARIN_PROJECT=$PROJECT_NAME.Xamarin.csproj

XCODE_BUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
SHARPIE_OUTPUT_FOLDER=$PROJECT_NAME/SharpieGenerated
MDS_PROJECT=movesense-mobile-lib/IOS/MovesenseApi/MovesenseApi.xcodeproj
INITIAL_MDS_FRAMEWORK=movesense-mobile-lib/IOS/MovesenseApi/build/Release-iphoneos/MovesenseApi.framework
TARGET_MDS_FRAMEWORK=$BUILD_FOLDER/MovesenseApi.framework

rm -rf $BUILD_FOLDER
rm -rf $PROJECT_NAME/obj
mkdir -p $BUILD_FOLDER

$XCODE_BUILD ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO -project $MDS_PROJECT -configuration Release -sdk iphoneos build

cp -r $INITIAL_MDS_FRAMEWORK $TARGET_MDS_FRAMEWORK
 
sharpie bind -sdk iphoneos -o $SHARPIE_OUTPUT_FOLDER -n $PROJECT_NAME -f $TARGET_MDS_FRAMEWORK

dotnet build $PROJECT_NAME/$NET_PROJECT -c Release

rm -rf $PROJECT_NAME/obj

msbuild $PROJECT_NAME/$XAMARIN_PROJECT -t:Rebuild -restore:True -p:Configuration=Release

nuget pack $PROJECT_NAME.nuspec