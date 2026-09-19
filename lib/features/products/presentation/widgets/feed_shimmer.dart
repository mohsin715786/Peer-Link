import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class FeedShimmerGrid extends StatelessWidget {
  const FeedShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          padding: const EdgeInsets.all(8),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ShimmerBox(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 12,
                ),
              ),
              SizedBox(height: 12),
              ShimmerBox(width: 110, height: 14, borderRadius: 4),
              SizedBox(height: 8),
              ShimmerBox(width: 80, height: 12, borderRadius: 4),
              SizedBox(height: 8),
              ShimmerBox(width: 60, height: 10, borderRadius: 4),
            ],
          ),
        );
      },
    );
  }
}
