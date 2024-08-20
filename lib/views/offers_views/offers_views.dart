import 'package:flutter/material.dart';
import 'package:mt_of_wac/widgets/commen_custom_page_text_widget.dart';

class OffersViews extends StatelessWidget {
  const OffersViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CommenCustomPageTextWidget(text: 'Offers Screen')),
    );
  }
}
