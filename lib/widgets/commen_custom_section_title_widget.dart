import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';

class CommenCustomSectionTitleWidget extends StatelessWidget {
  const CommenCustomSectionTitleWidget({
    super.key,
    this.title,
  });
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: GoogleFonts.montserrat(
            color: kBlack,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: null,
          child: Text(
            'View all',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: kGreyShade900,
            ),
          ),
        ),
      ],
    );
  }
}
