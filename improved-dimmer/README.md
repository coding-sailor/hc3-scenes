# Improved Dimmer - Smart Dimmer Control

This scene provides intelligent dimmer control triggered by double-click events on a wall switch. It automatically adjusts brightness based on current light level and time of day conditions.

## Functionality

The scene controls Dimmer device by cycling through brightness levels with each double-click:
- **High brightness (≥70%)**: Dims to 30%
- **Medium brightness (≥10%)**: Dims to 2% (night light) when dark outside, or jumps to 100% during day time
- **Low brightness (<10%)**: Sets to 100% (full brightness)

This creates a brightness loop: **100% → 30% → 2% (when dark) → 100%** or **100% → 30% → 100%** (during day time)

## Implementation

### Condition script

```lua
{
  conditions = { {
      id = <SWITCH_ID>,
      isTrigger = true,
      operator = "==",
      property = "sceneActivationEvent",
      type = "device",
      value = 14
    } },
  operator = "any"
}
```

**Trigger Details:**
- **Device**: Wall switch
- **Event**: Scene activation event 14 (double-click)
- **Trigger**: Immediate activation on double-click

### Scene code
  
[➜ Scene Implementation](scene.lua)

## Setup

1. **Replace parameters in condition and scene code**:
   - `<SWITCH_ID>` - wall switch device ID (e.g. `100`)
   - `<DIMMER_ID>` - dimmable light device ID (e.g. `101`)
2. **Set up global variable**: Create and maintain the `is_it_dark_outside` global variable by following the **[Global Variables Setup Guide](../GLOBAL_VARIABLES_SETUP.md)**. This variable is essential for intelligent brightness control based on time of day.
3. **Configure dimmer device**: Set your dimmer device `Parameter 23` to `0` to disable the default 100% brightness on double-click. This prevents conflicts with the scene's intelligent brightness control.
   - Go to device settings → Parameters → `Parameter 23: Double click option` → Set value to `0`

