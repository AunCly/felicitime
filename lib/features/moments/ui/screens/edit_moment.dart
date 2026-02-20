import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/picture/models/image.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:felicitime/ui/widgets/date_input.dart';
import 'package:felicitime/ui/widgets/form_error_message.dart';
import 'package:felicitime/ui/widgets/info_message.dart';
import 'package:felicitime/ui/widgets/picture_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class EditMoment extends ConsumerStatefulWidget {
  const EditMoment({super.key, required this.moment});

  final Moment moment;

  @override
  ConsumerState<EditMoment> createState() => _EditMomentState();
}

class _EditMomentState extends ConsumerState<EditMoment> {
  late final TextEditingController _noteEditingController;
  late final TextEditingController _dateEditingController;
  late final TextEditingController _realDateEditingController;
  late List<MediaModel> pictures;
  bool imageError = false;
  bool dateError = false;

  @override
  void initState() {
    super.initState();
    _noteEditingController = TextEditingController(text: widget.moment.comment ?? '');
    _dateEditingController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.moment.createdAt));
    _realDateEditingController = TextEditingController(text: widget.moment.createdAt.toString());
    pictures = List<MediaModel>.from(widget.moment.medias);
  }

  @override
  void dispose() {
    _noteEditingController.dispose();
    _dateEditingController.dispose();
    _realDateEditingController.dispose();
    super.dispose();
  }

  void save() {
    setState(() {
      imageError = pictures.isEmpty;
      dateError = _dateEditingController.text.isEmpty;
    });

    if (imageError || dateError) return;

    ref.read(capsuleRepositoryProvider).updateMoment(
      moment: widget.moment,
      data: {
        'medias': pictures,
        'comment': _noteEditingController.text,
        'date': _realDateEditingController.text,
      },
    );

    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        content: Text('Moment modifié.', style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackHome(),
            Text('Modifier.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text(widget.moment.capsule.title, style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            const AppInfoMessage(
              message: 'Vous pouvez modifier les photos et la note de votre moment.',
              icon: FontAwesomeIcons.lightTriangleExclamation,
            ),
            gapHNormal,
            AppDateInput(
              label: 'Date *',
              dateEditingController: _dateEditingController,
              realDateEditingController: _realDateEditingController,
              error: dateError,
            ),
            if (dateError) const AppFormValidationErrorMessage(message: 'La date est obligatoire'),
            gapHNormal,
            MediaManager(
              title: 'Photos *',
              medias: pictures,
              canChoose: true,
              error: imageError,
            ),
            gapHNormal,
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Theme.of(context).colorScheme.surface,
                labelText: 'Note',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: true,
              ),
              cursorColor: Theme.of(context).colorScheme.primary,
              controller: _noteEditingController,
              textInputAction: TextInputAction.done,
              enableSuggestions: true,
              maxLines: 5,
            ),
            gapHNormal,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: save,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FontAwesomeIcons.lightCheck, color: Theme.of(context).colorScheme.surface, size: 15),
                    gapWNormal,
                    Text('Enregistrer', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                  ],
                ),
              ),
            ),
            gapHNormal,
          ],
        ),
      ),
    );
  }
}
