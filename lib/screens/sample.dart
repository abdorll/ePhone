import 'package:ephoneandsystems/utils/colors.dart';
import 'package:ephoneandsystems/utils/image_path.dart';
import 'package:ephoneandsystems/utils/instances.dart';
import 'package:ephoneandsystems/widgets/spacing.dart';

class ImageColor extends StatelessWidget {
  ImageColor({super.key});
  List<String> colorCodes = [
    "0000FF", // Blue
    "FF0000", // Red
    "00FF00", // Green
    "FFFF00", // Yellow
    "FFC0CB", // Pink
    "FFA500", // Orange
    "800080", // Purple
    "FFFFFF"
        "808080", // Gray
    "A52A2A", // Brown
    "40E0D0", // Turquoise
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/pure_individual_hand.png"),
            ...colorCodes
                .map(
                  (code) => Column(
                    children: [
                      ImageIcon(
                        AssetImage("assets/images/pure_individual_hand.png"),
                        color: Color(int.parse("0xFF$code")),
                        size: 100,
                      ),
                      YMargin(10)
                    ],
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}
