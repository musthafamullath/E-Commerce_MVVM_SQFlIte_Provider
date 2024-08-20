import 'package:flutter/material.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/widgets/commen_custom_build_product_card_widgets.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';
import 'package:provider/provider.dart';

class CustomProductCardWidget extends StatelessWidget {
  const CustomProductCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Consumer<DataViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.popularProducts.isEmpty) {
            return Center(
              child: commenCustomspinkitWidget(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: viewModel.popularProducts.length,
            itemBuilder: (context, index) {
              final product = viewModel.popularProducts[index];
              return buildProductCard(product, context);
            },
          );
        },
      ),
    );
  }
}
