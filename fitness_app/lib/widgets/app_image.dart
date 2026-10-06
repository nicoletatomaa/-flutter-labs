import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Imagine din assets care umple spațiul disponibil.
/// Dacă fișierul lipsește, se afișează un fundal închis (aplicația rulează oricum).
class AppImage extends StatelessWidget {
  const AppImage(this.path, {super.key, this.fit = BoxFit.cover});

  final String path;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Container(color: AppColors.grey700),
    );
  }
}
