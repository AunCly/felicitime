import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/widgets/validate_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidateCapsule extends ConsumerStatefulWidget {
  const ValidateCapsule({super.key, required this.capsule});

  final Capsule capsule;

  @override
  ConsumerState<ValidateCapsule> createState() => _ValidateCapsuleState();
}

class _ValidateCapsuleState extends ConsumerState<ValidateCapsule> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.capsule.title, style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  Text(widget.capsule.description, style: Theme.of(context).textTheme.bodyMedium),
                ]
              ),
            ),
            gapHNormal,
            ValidateCapsuleWidget(capsule: widget.capsule),
          ],
        ),
      )
    );
  }
}
