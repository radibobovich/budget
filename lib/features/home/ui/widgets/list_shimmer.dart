import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //     child: Column(
    //   children: List.generate(10, (i) => i).map((i) {
    //     return Shimmer.fromColors(
    //       baseColor: context.colors.shimmerBase,
    //       highlightColor: context.colors.shimmerHighlight,
    //       // gradient: context.colors.shimmerGradient,
    //       direction: ShimmerDirection.ltr,
    //       child: Container(
    //         height: 80,
    //         // color: context.colors.shimmerGradient.colors.last,
    //         decoration: BoxDecoration(
    //             color: Colors.black, borderRadius: BorderRadius.circular(16)),
    //       ),
    //     );
    //   }).toList(),
    // ));
    return Shimmer.fromColors(
      baseColor: context.colors.shimmerBase,
      highlightColor: context.colors.shimmerHighlight,
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, __) {
            return Container(
              height: 80,
              // color: context.colors.shimmerGradient.colors.last,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(16)),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemCount: 10),
    );
  }
}
