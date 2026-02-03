# Home Report - Home Status Notification

This scene generates comprehensive home status reports and sends them via Pushover notifications using the [Pushover Quick App](https://github.com/coding-sailor/hc3-pushover-qa). It provides information about active lights and open doors/windows, helping you monitor your home's current state.

## Requirements

- [Pushover Quick App for HC3](https://github.com/coding-sailor/hc3-pushover-qa) - must be installed and configured on your Home Center 3

## Functionality

The scene creates a detailed report including:

### 💡 Active Lights
- Scans all light devices in the home
- Reports lights that are currently on (>0% brightness or boolean true)
- Groups lights by room for better readability
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
   - `<PUSHOVER_QA_ID>` - ID of the Pushover Quick App installed on your HC3 (e.g. `210`)
   - `<ALTERNATIVE_USER_ID>` - Fibaro user ID that triggers notification to alternative Pushover user (e.g. `10`)
   - `<ALTERNATIVE_QUICK_APP_USER_NAME>` - Name of the alternative user configured in Pushover Quick App (e.g. `"spouse"`)
   - `<SENSOR_ID_1>`, `<SENSOR_ID_2>`, `...` - Your door/window sensor IDs (e.g. `123`, `124`, `125`)
   - `<PRIORITY_WARNING_SENSOR_ID>` - Sensor ID that displays with warning icon (⚠️) for visual distinction (e.g. `124`)

### Pushover notification options
- `PUSHOVER_PRIORITY` - Low priority (`-1`)
- `PUSHOVER_TTL` - 12 hours (`43200` seconds)
