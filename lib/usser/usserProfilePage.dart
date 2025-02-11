import 'package:flutter/material.dart';

class usserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Row on Top of Column')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              profilePhoto(imageUrl: "placeholder", name: "name"),
              Text('Row Item 2'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Column Item 1'),
                Text('Column Item 2'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class profilePhoto extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double imageSize;
  final TextStyle? textStyle;

  const profilePhoto({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.imageSize = 100.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(imageSize / 2),
          child: Image.network(
            imageUrl,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.person,
              size: imageSize,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          name,
          style: textStyle ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}



