import 'package:flutter/material.dart';

class OfflineHeader extends StatelessWidget {
  const OfflineHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      width: double.infinity,
      image: AssetImage('images/boardgame.jpg'),
      fit: BoxFit.cover,
    );
  }
}
