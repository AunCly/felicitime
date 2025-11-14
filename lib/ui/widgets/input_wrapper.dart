import 'package:flutter/material.dart';

class InputWrapper extends StatelessWidget {
  const InputWrapper({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(color: Theme.of(context).colorScheme.inverseSurface, width: 2),
        ),
      ),
      child: child,
    );
  }
}
