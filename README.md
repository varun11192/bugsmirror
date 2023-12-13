# Complaint Management System

This Complaint Management System is built using Flutter and Firebase, allowing users to submit complaints and administrators to manage them efficiently.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Firebase Configuration](#firebase-configuration)
- [Usage](#usage)
    - [Default Admin User](#default-admin-user)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Features

- User authentication via email/password and Google sign-in.
- User complaint submission with a title, summary, and severity rating.
- Admin dashboard for complaint management (e.g., marking as resolved or pending).

## Installation

### Prerequisites

- Flutter SDK installed. [Install Flutter](https://flutter.dev/docs/get-started/install)
- Git installed. [Install Git](https://git-scm.com/downloads)

### Firebase Configuration

1. Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
2. Enable Firebase Authentication and Firestore for your project.
3. Download the `google-services.json` file for Android or `GoogleService-Info.plist` for iOS.
4. Place these configuration files in the respective platform folders:
    - `android/app` for Android
    - `ios/Runner` for iOS

User Guide
Register / Login

Use your email and password to sign up or log in.
Use the Google sign-in option for faster access.
Complaint Submission

Fill in the title, summary, and severity of your complaint.
Submit your complaint for resolution.
View Complaint Status

Check the status of your complaints (resolved, pending, or in progress) in the dashboard.
Admin Access

Admin users can log in with specific credentials.
Admins can manage complaints, mark them as resolved or pending.
Sign Out

Log out of your account after usage for security.
Default Admin Credentials
Email: hi@gmail.com
Password: 123456


