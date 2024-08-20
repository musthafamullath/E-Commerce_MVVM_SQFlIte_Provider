import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CommenCustomProductCardTextWidget extends StatelessWidget {
  const CommenCustomProductCardTextWidget({
    super.key,
    required this.text,
    required this.color,
    this.textDecoration,
    this.maxLines,
    this.textOverflow,
  });

  final String text;
  final Color color;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        color: color,
        fontSize: 8,
        fontWeight: FontWeight.bold,
        decoration: textDecoration,
      ),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
