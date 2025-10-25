# Video Overlay App

- A project that is showing the continuous looping of video with text overlay on it.

- This project demonstrates a Flutter-based custom video player with an overlay text and hidden control


## Overview

Approach Explanation

The implementation is split into two main parts:

1. Controller (HomeScreenController)

Handles the lifecycle of VideoPlayerController.

Initializes the video (from network).


Manages play/pause and cleanup in dispose().

2. View (HomeScreenView)

Uses a OrientationBuilder to maintain a landscape-style aspect ratio (16:9) regardless of device orientation.

Builds a Stack containing:

Video player (with rounded corners and shadows).

Overlay text (always visible).

Hidden video controls (shown when tapped).

A state variable showControls (controlled via GestureDetector) toggles visibility of play/pause

Animations and opacity transitions are used for a smooth, modern feel.

##  Features

✅ Auto-playing and looping background video  
✅ Centered overlay text (customizable)  
✅ Semi-transparent background for readability  
✅ Responsive design for phones, tablets, TVs, and web  
✅ Tap-to-toggle controls (progress indicator).
✅ Smooth animations and adaptable layout for both portrait and landscape orientations.  
✅ Floating Settings ⚙️ button to change:
   - Overlay text  
   - Text color  
   - Font size 

## Dependencies

Add these to your pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  video_player: ^2.10.0
  video_player_web: ^2.4.0

- Package Description
   - video_player: Handles video playback across android, ios, mac, windows platforms
   - video_player_web: Handles video playback across web platform

  ##  Requirements

- Flutter SDK 3.35.6
- Dart 3.9.2
- Internet connection because the video is online

## ⚙️ Customization

You can easily customize:

- Default text: Change overlayText which has a default text of "Welcome to InfiniteSimul"

- Default color: Update overlayColor

- Default font size: Adjust fontSize

- At runtime, press the ⚙️ floating button to open settings and update text, font size, and color dynamically.

## 🛠️ Setup Instructions

1. **Clone this repository**
   ```bash
   git clone https://github.com/cn-techlite/Video_Overlay_App.git
   cd Video_Overlay_App