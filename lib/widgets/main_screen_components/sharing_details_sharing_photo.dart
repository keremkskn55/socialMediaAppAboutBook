import 'package:flutter/material.dart';

class SharingDetailsSharingPhoto extends StatelessWidget {
  const SharingDetailsSharingPhoto({
    Key? key,
    required this.size,
    required this.url,
  }) : super(key: key);

  final Size size;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size.width / 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),
      ],
    );
  }
}
