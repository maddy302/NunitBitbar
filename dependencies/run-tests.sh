#!/usr/bin/env bash

echo "Extracting tests.zip..."
unzip tests.zip

echo "Installing android sdk tools for the device..."
ANDROID_SDK_VERSION=`adb shell getprop ro.build.version.sdk`
echo 'y' | sdkmanager "platform-tools" "platforms;android-${ANDROID_SDK_VERSION}" >/dev/null

echo "Installing dependencies..."
wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe >/dev/null

mono nuget.exe install NUnit
mono nuget.exe install NUnit.ConsoleRunner
mono nuget.exe install NUnit3TestAdapter
mono nuget.exe install Xamarin.UITest

echo "Running tests..."

mono NUnit.ConsoleRunner.3.10.0/tools/nunit3-console.exe UITestDemo.UITest.dll --result="TEST-all.xml;transform=nunit3-junit.xslt"

echo "Finished running tests!"
