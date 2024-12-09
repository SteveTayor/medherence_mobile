# medherence

Medherence is a Flutter project designed to improve medical adherence through a mobile application.

## Table of Contents

- [medherence](#medherence)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Features](#features)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Troubleshooting](#troubleshooting)
  - [Contributing](#contributing)

---

## Overview

Medherence is a mobile application built with Flutter to enhance medical adherence. It helps users manage their medication schedules, medication alarm reminders, regulation of proper use of medication and maintain communication with healthcare providers. 

---

## Features

- **Medication Reminders**: Set personalized reminders for medication intake times.
- **Profile Management**: Manage user profiles, including personal details and emergency contacts.
- **Notifications**: Receive notifications for medication reminders and health updates.
- **Biometric Authentication**: Secure access using fingerprint or facial recognition.
- **Localization**: Support for multiple languages.
- **Responsive Design**: Adapted for various screen sizes using `flutter_screenutil`.

---

## Dependencies

Medherence utilizes several Flutter packages to achieve its functionality:

- **stacked**: Provides architectural support for MVVM (Model-View-ViewModel) pattern, aiding in separation of concerns and state management.
- **provider**: Implements the provider pattern for state management, allowing efficient management and propagation of application state.
- **flutter_local_notifications**: Facilitates local notifications on both Android and iOS platforms, essential for timely medication reminders.
- **android_alarm_manager_plus**: Enables scheduling background tasks on Android, crucial for executing periodic reminders.
- **shared_preferences**: Stores simple data locally on the device, used for storing user preferences and settings.
- **flutter_screenutil**: Assists in creating responsive UI designs that adapt to different device sizes and orientations.
- **url_launcher**: Launches URLs from within the application, supporting integration with external medical resources or websites.
- **jiffy**: Provides date and time formatting utilities, ensuring consistency and clarity in displaying timestamps.
- **local_auth**: Integrates biometric authentication (fingerprint, face recognition) for enhanced security when accessing sensitive features.
- **camera**: Accesses the device's camera, supporting functionalities like scanning prescriptions or documenting health-related information.

---

## Installation

To run the Medherence app on your local machine, follow these steps:

1. **Clone Repository**:
   ```bash
   git clone https://github.com/medherence-health/mobile_view.git
2. **Navigate to Project Directory**:
   ```bash
   cd medherence
3. **Install Dependencies**:
   ```bash
   flutter pub get

## Usage
 **Debugging on Device**
 - To debug and run Medherence on your device:

 - **Connect Device**:
   Connect your Android/iOS device to your computer via USB and ensure USB debugging is enabled.
 - **Run Application**:
    ```bash
    flutter run
This command builds and deploys the application to your connected device.


## Troubleshooting
- If you encounter any issues while setting up or running Medherence, consider the following steps:

- **Update Flutter SDK**: Ensure you have the latest version of the Flutter SDK installed by running
  ```bash
  flutter upgrade.

- **Clear Flutter Cache**: Sometimes clearing the Flutter cache can resolve dependency-related issues:

    ```bash
    flutter pub cache repair
- **Check Device Connectivity**: Verify that your device is properly connected and recognized by running flutter devices.

- **Review Logs**: Check the console output for error messages or warnings that might indicate the cause of the issue.

## Contributing
 - Contributions to Medherence are welcome! If you find bugs, have feature requests, or want to contribute code, please submit an issue or a pull request on GitHub.

