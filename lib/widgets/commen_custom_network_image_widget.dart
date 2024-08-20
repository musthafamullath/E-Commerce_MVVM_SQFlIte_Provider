import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mt_of_wac/widgets/commen_custom_spinkit_widget.dart';


class  CommenCustomNetWorkImageWidget extends StatelessWidget {
  final String imageUrl;

  const  CommenCustomNetWorkImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: SizedBox(
          height: 110,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.fill,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return Image.file(
                    File(imageUrl),
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
            ],
          ),
        ),
      ),
    );
  }
}
