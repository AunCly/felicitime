import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsule_controller.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CapsuleListTile extends ConsumerStatefulWidget {
  const CapsuleListTile({super.key, required this.capsule});

  final Capsule capsule;

  @override
  ConsumerState<CapsuleListTile> createState() => _CapsuleListTileState();
}

class _CapsuleListTileState extends ConsumerState<CapsuleListTile> {

  selectCapsule(int id) async {
    ref.read(selectCapsuleControllerProvider.notifier).selectCapsule(id);
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue capsule = ref.watch(currentCapsuleStreamProvider);

    return AsyncValueWidget(
      value: capsule,
      data: (value) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          title: Text(widget.capsule.title),
          subtitle: Text(widget.capsule.description),
          trailing: widget.capsule.id == value.id ? Text('Sélectionnée') : Text('Choisir'),
          onTap: () => selectCapsule(widget.capsule.id)
        ),
      )
    );
  }
}
