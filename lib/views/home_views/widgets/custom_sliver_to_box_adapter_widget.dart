import 'package:flutter/material.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/widgets/commen_custom_build_product_card_widgets.dart';
import 'package:mt_of_wac/widgets/commen_custom_section_title_widget.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';
import 'package:provider/provider.dart';

class CustomSliverToBoxAdapterWidget extends StatelessWidget {
  const CustomSliverToBoxAdapterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommenCustomSectionTitleWidget(title: 'Most Popular'),
            SizedBox(
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
                    itemCount: viewModel.popularProducts.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.popularProducts[index];
                      return buildProductCard(product, context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
