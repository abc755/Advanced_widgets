import 'package:advanced_widgets/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends InheritedWidget {
  final ProfileTheme theme;

  const ProfileWidget({required this.theme, super.key, required super.child});

  static ProfileTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ProfileWidget>();
    assert(result != null, 'No ProfileWidget found in context');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(ProfileWidget oldWidget) => theme != oldWidget.theme;
}