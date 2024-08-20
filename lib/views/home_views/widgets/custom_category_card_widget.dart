import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/widgets/commen_custom_product_card_text_widget.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';
import 'package:provider/provider.dart';

class CustomCategoryCardWidget extends StatelessWidget {
  const CustomCategoryCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 75,
      child: Consumer<DataViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.categories.isEmpty) {
            return Center(
              child: commenCustomspinkitWidget(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.categories.length,
            itemBuilder: (context, index) {
              final category = viewModel.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  width: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: kGreyShade300,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: CachedNetworkImage(
                          imageUrl: category.imageUrl,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          placeholder: (context, url) => SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: commenCustomspinkitWidget(),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.file(File(category.imageUrl)),
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CommenCustomProductCardTextWidget(
                        text: category.title,
                        color: kBlack,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
