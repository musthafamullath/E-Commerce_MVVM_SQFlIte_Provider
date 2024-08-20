import 'package:flutter/material.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/widgets/commen_custom_network_image_widget.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';
import 'package:provider/provider.dart';

class CustomSingleBannerWidget extends StatelessWidget {
  const CustomSingleBannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DataViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.singleBanners.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Center(
              child: commenCustomspinkitWidget(),
            ),
          );
        }
        return Column(
          children: viewModel.singleBanners.map((singleBanner) {
            return CommenCustomNetWorkImageWidget(
              imageUrl: singleBanner.imageUrl,
            );
          }).toList(),
        );
      },
    );
  }
}
