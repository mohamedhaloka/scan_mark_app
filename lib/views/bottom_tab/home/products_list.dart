import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/views/bottom_tab/home/product_card.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: customHeight(context, 0.00072)),
        itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 575),
          child: SlideAnimation(
            verticalOffset: 150.0,
            child: ProductCard(),
          ),
        ),
        itemCount: 7,
      ),
    );
  }
}
