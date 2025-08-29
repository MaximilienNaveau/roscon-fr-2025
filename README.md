# roscon-fr-2025
Abstract and demo for the roscon-fr-2025

## Build the abstract

```bash
cd doc
make
```

## Execute the demo

### Phase 1 show the interfaces.

- Terminal 1
```bash
ros2 launch ros2_control_demo_example_1 rrbot.launch.py
```

- Terminal 2
```bash
ros2 launch ros2_control_demo_example_1 test_forward_position_controller.launch.py
```

- Terminal 3
```bash
ros2 run  plotjuggler plotjuggler
```

### Phase 2 launch the custom node

- Terminal 1
```bash
ros2 launch ros2_control_demo_example_1 rrbot.launch.py
```

- Terminal 2
```bash
ros2 launch pal_stats_demo test_forward_position_controller.launch.py
```

- Terminal 3
```bash
ros2 run  plotjuggler plotjuggler
```
