import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String title;
  final List<String>? items;

  const HomeContainer({
    Key? key,
    required this.title,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 1),
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
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
