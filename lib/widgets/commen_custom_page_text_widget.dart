import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mt_of_wac/sources/custom_source_widgets.dart';

class CommenCustomPageTextWidget extends StatelessWidget {
  const CommenCustomPageTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: kGreyShade800,
      ),
    );
  }
}
