# roscon-fr-2025
Abstract and demo for the roscon-fr-2025

## Build the abstract

```bash
cd abstract
make
```

## Build the presentation

The presentation is currently a google doc.
So one need to export it in PDF.
Some work may be done to convert to Beamer.

I one see a beamer presentation in the `presentation` folder, one can
```bash
cd presentation
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
ros2 run plotjuggler plotjuggler
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
ros2 run plotjuggler plotjuggler
```
