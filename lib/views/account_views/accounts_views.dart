import 'package:flutter/material.dart';

import 'package:mt_of_wac/widgets/commen_custom_page_text_widget.dart';

class AccountsViews extends StatelessWidget {
  const AccountsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CommenCustomPageTextWidget(text: 'Account Screen')),
    );
  }
}
