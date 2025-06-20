# RGBW LED - Advanced LED Strip Controller

This scene provides comprehensive control for RGBW LED strips with multiple interaction modes. It supports single, double, and triple clicks, plus hold gestures for different lighting effects and color cycling.

## Functionality

### Click Interactions

**Single Click (Scene Event 26)**
- **Light OFF**: Turns on with default brightness and current color step
- **Light ON**: Turns off the light

**Double Click (Scene Event 24)**
- **Light OFF**: Turns on with white color (step 1) at 100% brightness
- **Light ON**: Cycles through brightness levels with each double-click:
  - **High brightness (≥60%)**: Dims to 30%
  - **Medium brightness (≥10%)**: Dims to 2% when dark outside, or jumps to 100% during day time
  - **Low brightness (<10%)**: Sets to 100% (full brightness)

This creates a brightness loop: **100% → 30% → 2% (when dark) → 100%** or **100% → 30% → 100%** (during day time)

**Triple Click (Scene Event 25)**
- Cycles through color presets (steps 1-4)

### Hold/Release Interaction

**Hold Action (Scene Event 22)**
- **When brightness is low (≤10%)**: Begins brightening the light
- **When brightness is above 10%**: Begins dimming the light
- Tracks the last operation to prevent unwanted flickering effects

**Release Action (Scene Event 23)** 
- Stops level change operation

## Color Presets

1. **White**: `r=0, g=0, b=0, w=255`
2. **Cyan**: `r=0, g=255, b=255, w=0`
3. **Warm Orange**: `r=255, g=40, b=30, w=0`
4. **Program 4**: Built-in LED program

## Implementation

### Main Scene (1-2-3 Click)
**Condition script**
```lua
  {
    conditions = { {
        id = <SWITCH_ID>,
        isTrigger = true,
        operator = "==",
        property = "sceneActivationEvent",
        type = "device",
        value = 26
      }, {
        id = <SWITCH_ID>,
        isTrigger = true,
        operator = "==",
        property = "sceneActivationEvent",
        type = "device",
        value = 24
      }, {
        id = <SWITCH_ID>,
        isTrigger = true,
        operator = "==",
        property = "sceneActivationEvent",
        type = "device",
        value = 25
      } },
    operator = "any"
  }
```
**Scene code**  
[➜ Main Scene code](scene.lua)

### Hold Scene
**Condition script**
```lua
  {
    conditions = { {
        id = <SWITCH_ID>,
        isTrigger = true,
        operator = "==",
        property = "sceneActivationEvent",
        type = "device",
        value = 22
      } },
    operator = "all"
  }
```
**Scene code**  
**[➜ Hold Scene code](hold.lua)**

### Release Scene
**Condition script**
```lua
  {
    conditions = { {
        id = <SWITCH_ID>,
        isTrigger = true,
        operator = "==",
        property = "sceneActivationEvent",
        type = "device",
        value = 23
      } },
    operator = "all"
  }
```
**Scene code**  
**[➜ Release Scene code](release.lua)**

## Setup

1. **Replace parameters in condition and scene code**:
   - `<SWITCH_ID>` - wall switch device ID (e.g. `123`)
   - `<LED_ID>` - RGBW LED controller device ID (e.g. `234`)
2. **Set up global variables**: Create and maintain the required global variables by following the **[Global Variables Setup Guide](../GLOBAL_VARIABLES_SETUP.md)**. These variables (`is_it_dark_outside` and `default_light_value`) are essential for intelligent brightness and color control based on time of day.
3. Adjust color presets in the colors array as desired
