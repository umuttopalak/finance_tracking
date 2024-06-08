import 'package:finance_tracking/fonts/fonts.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String title;
  final List<String>? items;

  const HomeContainer({
    super.key,
    required this.title,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: bold18TextStyle
          ),
          const Divider(thickness: 1),
          if (items != null && items!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items!.map((item) {
                return Row(
                  children: [
                   
                    Checkbox(
                      value: false, // Checkbox değeri burada belirlenmeli
                      onChanged: (newValue) {
                        // Onay kutusunun değeri değiştiğinde yapılacak işlem
                      },
                    ),
                   Text(item),
                  ],
                );
              }).toList(),
            ),
          if (items == null || items!.isEmpty)
            Center(
              child: Text(
                'No items available',
                style: italicGreyTextStyle
              ),
            ),
        ],
      ),
    );
  }
}
