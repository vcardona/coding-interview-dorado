import 'package:coding_interview_dorado/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DecorativeBackground extends StatelessWidget {
  const DecorativeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Semicírculo grande en el lado derecho
        Positioned(
          top: size.height * -0.15,
          right: size.width * -1.5,
          child: Container(
            width: size.width * 1.95,
            height: size.width * 2.05,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
