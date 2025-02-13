import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AnimationHelper {
  static Widget fadeInTransition({
    required Widget child,
    Duration? duration,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration ?? AppConstants.animationNormal,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget slideInTransition({
    required Widget child,
    Duration? duration,
    Offset? beginOffset,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(
        begin: beginOffset ?? const Offset(0, 0.1),
        end: Offset.zero,
      ),
      duration: duration ?? AppConstants.animationNormal,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget scaleInTransition({
    required Widget child,
    Duration? duration,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: duration ?? AppConstants.animationNormal,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
} 