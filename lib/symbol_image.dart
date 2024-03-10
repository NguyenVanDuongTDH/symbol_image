// ignore_for_file: must_be_immutable, prefer_final_fields

library symbol_image;

import 'package:flutter/material.dart';
import 'package:state_view_widget/state_view_widget.dart';

class SymbolImage extends StateViewWidget {
  dynamic _state;
  Widget _child;
  List<double> _colorMatrix;
  Map<dynamic, Color> _mapColors;

  SymbolImage(
      {super.key,
      dynamic state = 0,
      Map<dynamic, Color> mapColors = const {0: Colors.grey},
      required Widget child})
      : _mapColors = mapColors,
        _child = child,
        _state = state,
        _colorMatrix = _color2Matrix(mapColors[mapColors.keys.toList()[0]]!);

  set tag(dynamic value) {
    value != _state
        ? {
            _state = value,
            _colorMatrix = _color2Matrix(_mapColors[value]!),
            reBuild()
          }
        : null;
  }

  @override
  StateView<SymbolImage> createState() => _SymbolImageState();
}

class _SymbolImageState extends StateView<SymbolImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ColorFiltered(
        colorFilter: ColorFilter.matrix(model._colorMatrix),
        child: model._child,
      ),
    );
  }
}

List<double> _color2Matrix(Color color) {
  List<double> getColorImage(double value) {
    value = value / 100;
    return <double>[
      0.3 * value,
      0.7 * value,
      0.3 * value,
      0.1 * value,
      0 * value
    ];
  }

  var colors = getColorImage(color.red.toDouble());
  colors.addAll(getColorImage(color.green.toDouble()));
  colors.addAll(getColorImage(color.blue.toDouble()));
  colors.addAll([1, 1, 1, 1, 1]);
  return colors;
}
