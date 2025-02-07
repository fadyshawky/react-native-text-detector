# React Native Text Detector

[![npm](https://img.shields.io/npm/dm/react-native-text-detector.svg)](https://www.npmjs.com/package/react-native-text-detector)


## See it in action
Checkout these blog for 
- [Business Card Reading App](https://heartbeat.fritz.ai/building-text-detection-apps-for-ios-and-android-using-react-native-42fe3c7e339) 
- [Delta ML - Comparison between different OCR SDKs (iOS)](https://heartbeat.fritz.ai/comparing-on-device-text-recognition-ocr-sdks-24f8a0423461)
- [Choose the Right On-Device Text Recognition (OCR) SDK on Android Using DeltaML](https://heartbeat.fritz.ai/https-heartbeat-fritz-ai-choose-the-right-on-device-text-recognition-sdk-on-android-using-deltaml-9b4b3e409b6e)

for example of this package.

## Different libraries
Default branch uses Tesseract on iOS and Firebase ML Kit on android. Beside that we have 2 branches

- [Firebase](https://github.com/zsajjad/react-native-text-detector/tree/firebase) it uses firebase on both platforms
- [Tesseract OCR](https://github.com/zsajjad/react-native-text-detector/tree/tesseract) it uses tesseract on both platforms

For deciding between which one is better check this blog on [Hearbeat by Fritz.ai](https://heartbeat.fritz.ai/comparing-on-device-text-recognition-ocr-sdks-24f8a0423461)

## Getting started

`$ npm install react-native-text-detector --save` or `yarn add react-native-text-detector`

## Automatic Linking
add the following line to your Podfile

`pod 'TesseractOCRiOS', :git => 'https://github.com/gali8/Tesseract-OCR-iOS.git'`

### Manual installation

#### iOS

##### Attach Tesseract Languages you want to use in your app 

Import your tessdata folder (you can download one for your language from [Google's Repo](https://code.google.com/p/tesseract-ocr/downloads/list) OR if that gives an error use [THIS REPO](https://github.com/tesseract-ocr/tessdata/tree/bf82613055ebc6e63d9e3b438a5c234bfd638c93) as referenced on [stack overflow as solution](https://stackoverflow.com/questions/41131083/tesseract-traineddata-not-working-in-swift-3-0-project-using-version-4-0/41168236#41168236) into the root of your project AS A REFERENCED FOLDER (see below). It contains the Tesseract trained data files. You can add your own trained data files here too.

NOTE: This library currently requires the tessdata folder to be linked as a referenced folder instead of a symbolic group. If Tesseract can't find a language file in your own project, it's probably because you created the tessdata folder as a symbolic group instead of a referenced folder. It should look like this if you did it correctly:

![alt text](https://cloud.githubusercontent.com/assets/817753/4598582/aeba675c-50ba-11e4-8d14-c7af9336b965.png "guide")

Note how the tessdata folder has a blue icon, indicating it was imported as a referenced folder instead of a symbolic group.

##### Also add `-lstdc++` if not already present

##### Using Pods (Recommended)
1. Add following in `ios/Podfile` 
```ruby
    pod 'RNTextDetector', path: '../node_modules/react-native-text-detector/ios'
```
2. Run following from project's root directory
```bash
    cd ios && pod install
```
3. Use `<your_project>.xcworkspace` to run your app

##### Direct Linking
1.  In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2.  Go to `node_modules` ➜ `react-native-text-detector` and add `RNTextDetector.xcodeproj`
3.  In XCode, in the project navigator, select your project. Add `libRNTextDetector.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4.  Run your project (`Cmd+R`)<

#### Android

This package uses Firebase ML Kit for text recognition on android please make sure you have integrated firebase in your app before started integration of this package. [Here is the guide](https://firebase.google.com/docs/android/setup) for Firebase integration.

1.  Open up `android/app/src/main/java/[...]/MainApplication.java`

- Add `import com.fetchsky.RNTextDetector.RNTextDetectorPackage;` to the imports at the top of the file
- Add `new RNTextDetectorPackage()` to the list returned by the `getPackages()` method

2.  Append the following lines to `android/settings.gradle`:
    ```
    include ':react-native-text-detector'
    project(':react-native-text-detector').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-text-detector/android')
    ```
3.  Insert the following lines inside the dependencies block in `android/app/build.gradle`:

    ```
    ...
    dependencies {
        implementation 'com.google.firebase:firebase-core:16.0.1'
        implementation 'com.google.firebase:firebase-ml-vision:17.0.0'

        implementation (project(':react-native-text-detector')) {
            exclude group: 'com.google.firebase'
        }
    }

    // Place this line at the end of file

    apply plugin: 'com.google.gms.google-services'

    // Work around for onesignal-gradle-plugin compatibility
    com.google.gms.googleservices.GoogleServicesPlugin.config.disableVersionCheck = true
    ```

4.  Insert the following lines inside the dependencies block in `android/build.gradle`:

    ```
    buildscript {
        repositories {
            google()
            ...
        }
        dependencies {
            classpath 'com.android.tools.build:gradle:3.0.1'
            classpath 'com.google.gms:google-services:4.0.1' // google-services plugin
        }
    }
    ```

## Usage

```javascript
/**
 *
 * This Example uses react-native-camera for getting image
 *
 */

import RNTextDetector from "react-native-text-detector";

export class TextDetectionComponent extends PureComponent {
  ...

  detectText = async () => {
    try {
      const options = {
        quality: 0.8,
        base64: true,
        skipProcessing: true,
      };
      const { uri } = await this.camera.takePictureAsync(options);
      const visionResp = await RNTextDetector.detectFromUri(uri);
      console.log('visionResp', visionResp);
    } catch (e) {
      console.warn(e);
    }
  };

  ...
}
```
