import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';
import 'package:mt_of_wac/viewmodels/data_view_model.dart';
import 'package:mt_of_wac/viewmodels/slider_banners_view_model.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';
import 'package:provider/provider.dart';

class CustomSliverAppBarWidget extends StatelessWidget {
  const CustomSliverAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Consumer2<DataViewModel, SliderBannersViewModel>(
          builder: (context, viewModel, indicatorProvider, child) {
            if (viewModel.banners.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60,left: 10),
                  child: commenCustomspinkitWidget(),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 94.5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: viewModel.banners.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final content = viewModel.banners[index];
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          content.imageUrl,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.file(
                              File(content.imageUrl),
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                            );
                          },
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            } else {
                              return Center(
                                child: commenCustomspinkitWidget(),
                              );
                            }
                          },
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 130,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        indicatorProvider.updateIndex(index);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 2.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(viewModel.banners.length, (index) {
                        return GestureDetector(
                          onTap: () => indicatorProvider.updateIndex(index),
                          child: Container(
                            width: 5.0,
                            height: 5.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: indicatorProvider.currentIndex == index
                                  ? kGreyShade300
                                  : kGreyShade600,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: kGreen,
      leading: GestureDetector(
        onTap: null,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 7.5,
            right: 7.5,
            left: 20,
          ),
          child: Image(
            color: kGreyShade700,
            image: const AssetImage(
              'assets/icons/cart.png',
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 1.5),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: kBlack.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            cursorColor: kGreyShade300,
            cursorWidth: 2.0,
            cursorHeight: 15.0,
            controller: null,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: kGrey),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.5),
              border: InputBorder.none,
              suffixIcon: Icon(
                Mdi.magnify,
                color: kGreyShade300,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.5, top: 10, bottom: 1.5),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.notifications_outlined,
                  size: 25,
                  color: kWhite,
                ),
              ),
              Positioned(
                top: 11,
                right: 18,
                child: Container(
                  width: 7.5,
                  height: 7.5,
                  decoration: const BoxDecoration(
                    color: kRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
