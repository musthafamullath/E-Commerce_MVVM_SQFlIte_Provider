import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mt_of_wac/models/products_model.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';
import 'package:mt_of_wac/widgets/commen_custom_product_card_text_widget.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';


Widget buildProductCard(ProductsModel products, BuildContext context) {
  List<Widget> buildStars(int rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: i <= rating ? kYellow : kGrey,
          size: 12,
        ),
      );
    }
    return stars;
  }

  Widget buildProductName(String name) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const maxLines = 2;
        final textStyle = GoogleFonts.montserrat(
          color: kBlack,
          fontWeight: FontWeight.bold,
          fontSize: 8,
        );

        final textSpan = TextSpan(
          text: name,
          style: textStyle,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: maxLines,
          ellipsis: '...',
          textDirection: TextDirection.ltr,
        )..layout(minWidth: constraints.minWidth);

        bool isOverflowing = textPainter.didExceedMaxLines;

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: isOverflowing
                    ? name.substring(
                        0,
                        textPainter
                            .getPositionForOffset(
                              Offset(
                                constraints.minWidth,
                                textPainter.height,
                              ),
                            )
                            .offset)
                    : name,
                style: textStyle,
              ),
              if (isOverflowing)
                TextSpan(
                  text: '...',
                  style: textStyle,
                ),
              if (isOverflowing)
                TextSpan(
                  text: '|',
                  style: textStyle,
                ),
            ],
          ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }

  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    controller: ScrollController(),
    child: Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kGreyShade300,
            width: 1,
          ),
        ),
        width: 105,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: CachedNetworkImage(
                imageUrl: products.productImage,
                placeholder: (context, url) => SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: commenCustomspinkitWidget(),
                  ),
                ),
                errorWidget: (context, url, error) => Image.file(
                  File(products.productImage),
                ),
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 25,
                    
                    decoration: BoxDecoration(
                      color: kBoxButtonColor,
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommenCustomProductCardTextWidget(
                        text: "Sale ${products.discount}%",
                        color: kBlack,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildProductName(products.productName),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: buildStars(products.productRating),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      CommenCustomProductCardTextWidget(
                        text:
                            '₹${products.offerPrice.replaceAll(RegExp(r'[^\d.]'), '')}',
                        color: kBlack,
                      ),
                      const SizedBox(width: 4),
                      CommenCustomProductCardTextWidget(
                        text:
                            '₹${products.actualPrice.replaceAll(RegExp(r'[^\d.]'), '')}',
                        color: kGrey,
                        textDecoration: TextDecoration.lineThrough,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7.5,
            ),
          ],
        ),
      ),
    ),
  );
}
