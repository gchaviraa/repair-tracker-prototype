# Repair Tracker App

**Repair Tracker** is a Flutter application that allows users to track the status of their device repairs using either a note number or phone number. It features a clean UI built with Material 3 and a two-tab navigation system.

---

## Features

- Home screen with a welcome message and contact info
- "Track My Device" button to quickly navigate to the tracking screen
- Track repair status via note number or phone number
- Step-by-step repair status visualization
- Built with Flutter using Material 3 components

---

## Structure

### `main.dart`

This file contains the core of the application, with the following components:

- `MyApp`: Root of the app; defines the theme and sets `MainNavigation` as the home screen.
- `MainNavigation`: A `StatefulWidget` that handles the bottom navigation bar between two screens:
  - `HomePage`: Landing screen with a welcome message and a button to track a device.
  - `RepairTrackingPage`: A screen where users can enter their note or phone number to see the repair progress.

---

## Screens

### HomePage
- Displays a welcoming message, icon, and a call-to-action button (`Track My Device`)
- Provides contact information such as phone number, working hours, and address

### RepairTrackingPage
- Two input fields: note number and phone number (one is enough to search)
- Simulated repair status data (`Map<String, String>`)
- Shows the progress using icons and vertical step indicators

---

### Requirements
- Flutter SDK (3.10+ recommended)
- Dart
- Android/iOS emulator or real device for testing

---

## Sample Status Data

Hardcoded mock repair data is used for demonstration:

```dart
final Map<String, String> _noteRepairs = {
  '1001': 'In Diagnosis',
  '1002': 'In Repair',
  '1003': 'Ready for Pickup',
};

final Map<String, String> _phoneRepairs = {
  '9151234567': 'In Diagnosis',
  '9159876543': 'In Repair',
  '9155551212': 'Ready for Pickup',
};

