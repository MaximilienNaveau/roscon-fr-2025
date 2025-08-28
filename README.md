# roscon-fr-2025
Abstract for the roscon-fr-2025

## Execute the demo

### Phase 1 show the interfaces.

- Terminal 1
```
ros2 launch ros2_control_demo_example_1 rrbot.launch.py
```

- Terminal 2
```
ros2 launch ros2_control_demo_example_1 test_forward_position_controller.launch.py
```

- Terminal 3
```
ros2 run  plotjuggler plotjuggler
```

### Phase 2 launch the custom node

- Terminal 1
```
ros2 launch ros2_control_demo_example_1 rrbot.launch.py
```

- Terminal 2
```
ros2 launch pal_stats_demo test_forward_position_controller.launch.py
```

- Terminal 3
```
ros2 run  plotjuggler plotjuggler
```