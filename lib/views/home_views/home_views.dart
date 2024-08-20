import 'package:flutter/material.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_sliver_app_bar_widget.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_sliver_list_widget.dart';
import 'package:mt_of_wac/views/home_views/widgets/custom_sliver_to_box_adapter_widget.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhite,
      body: CustomScrollView(
        shrinkWrap: true,
        scrollBehavior: MaterialScrollBehavior(),
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBarWidget(),
          CustomSliverToBoxAdapterWidget(),
          CustomSliverListWidget(),
        ],
      ),
    );
  }
}
