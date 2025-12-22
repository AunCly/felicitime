import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/settings/data/settings_repository.dart';
import 'package:felicitime/features/user/application/user_service.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:felicitime/features/user/model/user.dart';
import 'package:felicitime/features/user/ui/controllers/delete_account_controller.dart';
import 'package:felicitime/features/user/ui/controllers/reset_tutorial_controller.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/ui/widgets/alert_message.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/button.dart';
import 'package:felicitime/ui/widgets/button_loading.dart';
import 'package:felicitime/ui/widgets/card_button.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

class YouScreen extends ConsumerStatefulWidget {
  const YouScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _YouScreenState();
}

class _YouScreenState extends ConsumerState<YouScreen> {

  _deleteAccount(String? confirmation) async {
    if(confirmation == 'SUPPRIMER'){
      ref.read(deleteAccountControllerProvider.notifier).deleteAccount();
    }
  }

  _confirmDeleteAccount(){
    showDialog(
      context: context,
      builder: (BuildContext context){

        return StatefulBuilder(
          builder: (BuildContext context, state){
            TextEditingController confirmationController = TextEditingController();

            return Consumer(
              builder: (_, ref, __){
                AsyncValue state = ref.watch(deleteAccountControllerProvider);

                ref.listen<AsyncValue>(deleteAccountControllerProvider, (_, state) {
                  state.showSnackBarOnError(context);
                  if(!state.isLoading && !state.hasError){
                    state.showSnackBarOnSuccess(context, 'Votre compte a bien été supprimé. Bon vent moussaillon !');
                  }
                });

                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  insetPadding: const EdgeInsets.all(15),
                  title: Row(
                    children: [
                      Text('Suppression de compte', style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.lightTimes, color: Theme.of(context).colorScheme.primary),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppAlertMessage(message: 'La suppression de compte est définitive.', icon: FontAwesomeIcons.lightTriangleExclamation),
                      gapHNormal,
                      Text('Pour confirmer la suppression de votre compte, veuillez saisir "SUPPRIMER"', style: Theme.of(context).textTheme.bodyMedium),
                      gapHNormal,
                      TextField(
                        controller: confirmationController,
                        decoration: const InputDecoration(
                          labelText: 'SUPPRIMER',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      gapHNormal,
                      AppLoadingButton(
                        state: state,
                        label: 'Supprimer',
                        onPressed: () => _deleteAccount(confirmationController.text),
                        color: Theme.of(context).colorScheme.error,
                        icon: FontAwesomeIcons.lightTrash,
                      )
                    ],
                  ),
                );
              }
            );
          }
        );
      }
    );
  }

  _resetTutorial(){
    ref.read(resetTutorialControllerProvider.notifier).resetTutorial();
  }

  @override
  Widget build(BuildContext context) {

    PackageInfo packageInfo = ref.read(packageInfoProvider);
    AsyncValue<User?> me = ref.watch(getMeStreamProvider);

    ref.listen<AsyncValue>(resetTutorialControllerProvider, (_, state) {
      state.showSnackBarOnError(context);
      if(!state.isLoading && !state.hasError){
        state.showSnackBarOnSuccess(context, 'Le tutoriel a bien été réinitialisé.');
      }
    });

    AsyncValue theme = ref.watch(watchThemeProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: AsyncValueWidget(
        value: me,
        data: (meValue) => meValue != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => UserService.showProfilInformationsModelDialog(context, meValue),
              child: const AppCardButton(text: 'Modifier mes informations', icon: FontAwesomeIcons.lightUser)
            ),
            gapHNormal,
            GestureDetector(
                onTap: () => UserService.showAvatarDialog(context),
                child: const AppCardButton(text: 'Modifier mon avatar', icon: FontAwesomeIcons.lightAnchor)
            ),
            gapHNormal,
            AppButton(
              text: 'Réinitialiser le tutoriel',
              icon: FontAwesomeIcons.solidQuestionCircle,
              onPressed: _resetTutorial
            ),
            gapHNormal,
            const Divider(),
            Text('Suppression de compte', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            const AppAlertMessage(title: 'Attention!', message: 'La suppression de compte est définitive. Toutes vos données, y compris vos diagnostics et entretiens, seront effacées et ne pourront pas être récupérées.', icon: FontAwesomeIcons.lightWarning),
            gapHNormal,
            AppButton(
              text: 'Supprimer mon compte ?',
              icon: FontAwesomeIcons.solidTrash,
              onPressed: _confirmDeleteAccount,
              color: Theme.of(context).colorScheme.error,
            ),
            gapHNormal,
            Center(child: Text('Ludovik v${packageInfo.version}+${packageInfo.buildNumber}', style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ) : const SizedBox(),
      ),
    );
  }
}

