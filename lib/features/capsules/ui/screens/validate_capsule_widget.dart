import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/validate_capsule_controller.dart';
import 'package:felicitime/features/picture/models/image.dart';
import 'package:felicitime/ui/widgets/alert_message.dart';
import 'package:felicitime/ui/widgets/button_loading.dart';
import 'package:felicitime/ui/widgets/date_input.dart';
import 'package:felicitime/ui/widgets/form_error_message.dart';
import 'package:felicitime/ui/widgets/picture_manager.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ValidateCapsuleWidget extends ConsumerStatefulWidget {
  const ValidateCapsuleWidget({super.key, required this.capsule});

  final Capsule capsule;

  @override
  ConsumerState<ValidateCapsuleWidget> createState() => _ValidateCapsuleWidgetState();
}

class _ValidateCapsuleWidgetState extends ConsumerState<ValidateCapsuleWidget> {

  final ImagePicker picker = ImagePicker();
  final _formNewDiagnosisKey = GlobalKey<FormState>();
  final _diagnosisDateEditingController = TextEditingController();
  final _realDateEditingController = TextEditingController();
  List<MediaModel> pictures = [];
  bool dateError = false;
  bool imageError = false;

  validateCapsule() async {

    setState(() {
      dateError = _diagnosisDateEditingController.text.isEmpty;
      imageError = pictures.isEmpty;
    });

    if(dateError || imageError) {
      return;
    } else {
      ref.read(validateCapsuleControllerProvider.notifier).validateCapsule(data : {
        'capsule': widget.capsule,
        'date': _realDateEditingController.text,
        'medias': pictures,
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue state = ref.watch(validateCapsuleControllerProvider);
    ref.listen<AsyncValue>(validateCapsuleControllerProvider, (_, state) {
      state.showSnackBarOnError(context);
      if(!state.isLoading && !state.hasError){
        state.showSnackBarOnSuccess(context, 'La capsule a été valiée.');
      }
    });

    return Form(
      key: _formNewDiagnosisKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppAlertMessage(
            message: 'Les champs marqués d\'un (*) sont obligatoires',
            icon: FontAwesomeIcons.lightTriangleExclamation
          ),
          gapHNormal,
          AppDateInput(
            label: 'Date *',
            dateEditingController: _diagnosisDateEditingController,
            realDateEditingController: _realDateEditingController,
            error: dateError,
          ),
          if(dateError) const AppFormValidationErrorMessage(message: 'La date est obligatoire'),
          gapHNormal,
          MediaManager(
            title: 'Photos *',
            medias: pictures,
            canChoose: true,
            error: imageError
          ),
          if(imageError) const AppFormValidationErrorMessage(message: 'Vous devez ajouter au moins une photo'),
          gapHNormal,
          Row(
            children: [
              Expanded(
                child: AppLoadingButton(
                  label: 'Valider la capsule',
                  icon: FontAwesomeIcons.lightPlus,
                  state: state,
                  onPressed: validateCapsule,
                )
              )
            ],
          ),
          gapHNormal,
        ],
      ),
    );
  }
}
