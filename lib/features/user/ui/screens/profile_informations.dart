import 'package:felicitime/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/user/model/user.dart';
import 'package:felicitime/features/user/ui/controllers/update_informations_controller.dart';
import 'package:felicitime/ui/widgets/button_loading.dart';
import 'package:felicitime/utils/async_value_ui.dart';

class ProfilInformations extends ConsumerStatefulWidget {

  const ProfilInformations({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilInformationsState();
}

class _ProfilInformationsState extends ConsumerState<ProfilInformations> {

  final _formKey = GlobalKey<FormState>();
  var pseudoTextController = TextEditingController();
  String pseudo = '';

  @override
  void initState() {
    super.initState();
    pseudo = ref.read(sharedPreferencesProvider).getString('avatar') ?? '';
  }

  _updateProfile() async {
    if(_formKey.currentState!.validate()) {
      ref.read(updateInformationsControllerProvider.notifier).updateInformations(data: {
        'pseudo': pseudoTextController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue state = ref.watch(updateInformationsControllerProvider);
    ref.listen<AsyncValue>(updateInformationsControllerProvider, (_, state) {
      state.showSnackBarOnError(context);
      if(!state.isLoading && !state.hasError){
        state.showSnackBarOnSuccess(context, 'Profil mis à jour.');
        Navigator.pop(context);
      }
    });

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: pseudoTextController,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir un pseudo';
                    }
                    return null;
                  },
                ),
                gapHNormal,
                Row(
                  children: [Expanded(
                    child: AppLoadingButton(
                      state: state,
                      icon: FontAwesomeIcons.lightFloppyDisk,
                      label: 'Enregistrer',
                      onPressed: _updateProfile,
                    )
                  )],
                ),
              ],
            ),
          ),
          gapHNormal,
        ],
      ),
    );
  }
}
