import 'package:bytebank/components/feature_item.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  return widget is FeatureItem &&
      widget.textTitle == name &&
      widget.iconData == icon;
}
