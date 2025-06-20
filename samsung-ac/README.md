# Samsung AC - Smart Air Conditioning Control

This scene automatically manages air conditioning power through SmartThings integration. It monitors door/window sensors and turns off the AC when doors or windows are left open for extended periods.

## Functionality

The scene performs the following actions:
1. Monitors door/window sensor for "open" state for more than 15 seconds
2. When triggered, checks SmartThings AC status
3. If AC is currently running, sends power-off command via SmartThings API

## Implementation

### Condition script

```json
{
  conditions = { {
      duration = 15,
      id = <SENSOR_ID>,
      isTrigger = true,
      operator = "==",
      property = "value",
      type = "device",
      value = true
    } },
  operator = "all"
}
```

### Scene code

[➜ Scene Implementation](scene.lua)

## Setup

**Replace parameters in condition and scene code**:  
  - `<SENSOR_ID>` - door/window sensor ID (e.g. `123`)
  - `<TOKEN>` - SmartThings [API token](https://account.smartthings.com/tokens) (e.g. `c5f72e3d-488a-442e-9b1a-8d7f5e5c4b3a`)
  - `<DEVICE_ID>` - Samsung AC device ID (e.g. `a1b2c3d4-e5f6-7890-abcd-ef1234567890`)
  - `<SCENE_ID>`- Fibaro scene ID (e.g. `Scene165`)
