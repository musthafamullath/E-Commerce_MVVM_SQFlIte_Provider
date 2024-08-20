import 'package:flutter/material.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_category_card_widget.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_product_card_widget.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_single_banner_widget.dart';
import 'package:mt_of_wac/widgets/commen_custom_section_title_widget.dart';


class CustomSliverListWidget extends StatelessWidget {
  const CustomSliverListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 20),
          const CustomSingleBannerWidget(),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CommenCustomSectionTitleWidget(title: 'Categories'),
          ),
          const CustomCategoryCardWidget(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: CommenCustomSectionTitleWidget(
                title: 'Featured Products'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: CustomProductCardWidget(),
          ),
        ],
      ),
    );
  }
}
