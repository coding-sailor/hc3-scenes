# Home Report - Home Status Notification

This scene generates comprehensive home status reports and sends them via Pushover notifications. It provides information about active lights and open doors/windows, helping you monitor your home's current state.

## Functionality

The scene creates a detailed report including:

### 💡 Active Lights
- Scans all light devices in the home
- Reports lights that are currently on (>0% brightness or boolean true)
- Includes room name and device name for each active light
- Shows "none" if no lights are active

### 🪟 Open Doors/Windows
- Monitors specific door/window sensors (configurable device IDs)
- Reports open doors/windows with appropriate icons
- **Main door sensor** shows distinctive warning icon (⚠️) for better visibility
- Other sensors show window icon (🪟)
- Shows "none" if all doors/windows are closed

## Implementation

### Condition script
No specific trigger condition - This scene can be triggered manually or by other scenes/automations.

### Scene code

[➜ Scene Implementation](scene.lua)

## Setup

**Replace parameters in scene code**:
   - `<TOKEN>` - Pushover [API token](https://pushover.net/api) (e.g. `azGD...`)
   - `<DEFAULT_PUSHOVER_USER>` - Primary Pushover user key (used for automatic triggers or default user) (e.g. `uQiR...`)
   - `<ALTERNATIVE_PUSHOVER_USER>` - Secondary Pushover user key (used when triggered by specific user) (e.g. `u7g...`)
   - `<ALTERNATIVE_USER_ID>` - Fibaro user ID that triggers notification to alternative Pushover user (e.g. `10`)
   - `<SENSOR_ID_1>`, `<SENSOR_ID_2>`, `...` - Your door/window sensor IDs  (e.g. `123`, `124`, `125`)
   - `<PRIORITY_WARNING_SENSOR_ID>` - Main door sensor ID that displays with warning icon (⚠️) for visual distinction (e.g. `124`)
   - `<SCENE_ID>` - Your actual scene ID (e.g. `Scene42`)

### Additional Pushover configuration
- **Priority**: Low priority (-1)
- **TTL**: 12 hours (43200 seconds)
