// showbanner_widget.dart
import 'package:flutter/material.dart';

class ShowBannerWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClose;

  const ShowBannerWidget({
    super.key,
    required this.imagePath,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 1,
      child: Stack(
        children: [
          // ✅ 배너 이미지에 애니메이션 적용
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: Image.asset(
              imagePath,
              key: ValueKey(imagePath),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // ✅ X 버튼 오른쪽 상단
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.rectangle,
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
