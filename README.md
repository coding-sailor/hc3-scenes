# Fibaro HC3 LUA Scenes

This repository contains a collection of LUA scenes for Fibaro Home Center 3 (HC3) home automation system. Each scene is designed to automate specific home functions and improve daily living experience.

## Scenes Overview

### 📊 [Home Report](./home-report/)
Comprehensive home status reporting scene that sends detailed reports via Pushover notifications. Provides real-time information about active lights and open doors/windows, with special priority indicators for main door sensors and customizable user notifications.

### 🖱️ [Improved Dimmer](./improved-dimmer/)
Intelligent dimmer control scene triggered by double-click events on a wall switch. Automatically adjusts brightness based on current light level and time of day conditions, cycling through brightness levels: 100% → 30% → 2% (when dark) → 100%.

### 💡 [RGBW LED](./rgbw-led/)
Advanced RGB+W LED strip controller with comprehensive interaction modes. Supports single/double/triple clicks and hold/release gestures for different lighting effects, brightness control, and color cycling through presets.

### 🌡️ [Samsung AC](./samsung-ac/)
Smart air conditioning control scene with SmartThings integration. Automatically monitors door/window sensors and turns off AC when doors or windows are left open for more than 15 seconds, helping save energy and maintain climate control efficiency.

## Global Variables Setup

Some scenes in this repository rely on intelligent time-of-day and lighting condition logic. Before using these scenes, please set up the required global variables by following the **[Global Variables Setup Guide](./GLOBAL_VARIABLES_SETUP.md)**.

### Variables:
- **`is_it_dark_outside`**: Boolean variable indicating current lighting conditions
- **`default_light_value`**: Brightness percentage for time-based lighting control

## Installation

1. Copy the scene.lua content to your Fibaro HC3 scene editor
2. Configure the trigger conditions as specified in each scene's README.md file
3. Replace placeholder parameters (device IDs, API tokens, etc.) with your actual values
4. (Optional) Set up global variables following the [Global Variables Setup Guide](./GLOBAL_VARIABLES_SETUP.md) (required only for Improved Dimmer and RGBW LED scenes)
5. Test the scenes in your environment

## Requirements

- Fibaro Home Center 3
- Appropriate devices (switches, sensors, LED controllers) as required by each scene
- For some scenes: external service integrations (SmartThings, Pushover)
- Global variables setup for intelligent time-based functionality
