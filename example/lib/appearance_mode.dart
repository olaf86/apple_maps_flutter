// Demonstrates the Appearance Mode (Light/Dark/Unspecified) feature.
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'page.dart';

class AppearanceModePage extends ExamplePage {
  AppearanceModePage()
    : super(const Icon(Icons.dark_mode), 'Appearance mode (Light/Dark)');

  @override
  Widget build(BuildContext context) =>
      const SafeArea(child: _AppearanceBody());
}

class _AppearanceBody extends StatefulWidget {
  const _AppearanceBody();

  @override
  State<_AppearanceBody> createState() => _AppearanceBodyState();
}

class _AppearanceBodyState extends State<_AppearanceBody> {
  AppleMapController? _controller;
  MapAppearanceMode _mode = MapAppearanceMode.unspecified;

  void _onMapCreated(AppleMapController c) {
    _controller = c;
  }

  Future<void> _applyMode(MapAppearanceMode mode) async {
    setState(() => _mode = mode);
    // If the controller is ready, also apply at runtime. The initial value is
    // already passed via the AppleMap.appearanceMode parameter below.
    final controller = _controller;
    if (controller != null) {
      await controller.setAppearanceMode(mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AppleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.3349, -122.0090), // Apple Park
              zoom: 12,
            ),
            // Initial appearance mode follows the current selection.
            appearanceMode: _mode,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select appearance mode',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Unspecified (System)'),
                    selected: _mode == MapAppearanceMode.unspecified,
                    onSelected: (_) =>
                        _applyMode(MapAppearanceMode.unspecified),
                  ),
                  ChoiceChip(
                    label: const Text('Light'),
                    selected: _mode == MapAppearanceMode.light,
                    onSelected: (_) => _applyMode(MapAppearanceMode.light),
                  ),
                  ChoiceChip(
                    label: const Text('Dark'),
                    selected: _mode == MapAppearanceMode.dark,
                    onSelected: (_) => _applyMode(MapAppearanceMode.dark),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Note: Requires iOS 13+. On older iOS versions the setting '
                'is ignored.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
