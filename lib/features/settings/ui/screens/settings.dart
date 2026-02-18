import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:felicitime/features/user/ui/controllers/settings_controller.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/services/notification.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:felicitime/ui/widgets/info_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends ConsumerState<SettingsScreen> {

  Map familyOptions = {
    'family_yes': 'Oui',
    'family_near': 'Oui a quelques minutes',
    'family_no': 'Non',
    'family_all': 'Ne souhaite pas répondre',
  };

  Map priceOptions = {
    'price_high': 'Oui',
    'price_little': 'Quelques euros',
    'price_free': 'Non',
    'price_all': 'Ne souhaite pas répondre',
  };

  Map recurrenceOptions = {
    'day': 'Quotidienne',
    'week': 'Hebdomadaire',
    'month': 'Mensuelle',
  };

  Map notificationOptions = {
    'on': 'Activée',
    'off': 'Désactivée',
  };

  void setSetting(String key, value) async {
    await ref.read(settingsControllerProvider.notifier).setSettings(key, value);
  }

  void setNotification(String key, value) async {
    final service = NotificationService();
    if(value == 'on'){
      await service.requestPermissions();
      await service.scheduleDailyMoodNotification();
      await service.scheduleCapsuleNotification();
    } else {
      await service.cancelAll();
    }
    await ref.read(settingsControllerProvider.notifier).setSettings(key, value);
  }

  void setRecurrence(String key, value) async {
    print('value $value');
    final service = NotificationService();
    await ref.read(settingsControllerProvider.notifier).setSettings(key, value);
    await service.cancelCapsuleNotification();
    await service.scheduleCapsuleNotification();
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue settings = ref.watch(settingsStreamProvider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackHome(),
            Text('Vous.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text('Paramètres personnels', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            AsyncValueWidget(
              value: settings,
              data: (value) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Voulez-vous activer les notifications ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Vous recevrez une notification par jour pour le suivi d\'humeur et une notification pour votre capsule selon la récurrence que vous avez défini(e), pas une de plus.',),
                    gapHNormal,
                    Column(
                      children: [
                        for(var option in const ['on', 'off']) Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: value['notification'] == option ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.inverseSurface,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text(notificationOptions[option]),
                                onTap: () => setNotification('notification', option),
                              ),
                            ),
                            gapHNormal
                          ],
                        )
                      ]
                    ),
                  ]
                )
              )
            ),
            gapHNormal,
            AsyncValueWidget(
              value: settings,
              data: (value) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text('Etes vous entouré (famille, amis proche de chez vous) ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Cette information nous permet de mieux adapter la sélection de vos capsules fonction de votre situation géographique et sociale.'),
                    gapHNormal,
                    Column(
                      children: [
                        for(var option in const ['family_yes', 'family_near', 'family_no', 'family_all']) Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: value['family_n_friend'] == option ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.inverseSurface,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text(familyOptions[option]),
                                onTap: () => setSetting('family_n_friend', option),
                              ),
                            ),
                            gapHNormal
                          ],
                        )
                      ]
                    ),
                  ]
                )
              ),
            ),
            gapHNormal,
            AsyncValueWidget(
              value: settings,
              data: (value) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text('Acceptez-vous de dépenser quelques euros pour une capsule ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Cette information nous permet de mieux adapter la sélection de vos capsules selon votre situation financière.',),
                    gapHNormal,
                    Column(
                      children: [
                        for (var option in const ['price_free', 'price_little', 'price_high', 'price_all']) Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: value['money'] == option ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.inverseSurface,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text(priceOptions[option]),
                                onTap: () => setSetting('money', option),
                              ),
                            ),
                            gapHNormal,
                          ],
                        )
                      ]
                    ),
                  ]
                )
              ),
            ),
            gapHNormal,
            Text('Réccurence.', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            AsyncValueWidget(
              value: settings,
              data: (value) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Text('A quelle récurrence souhaitez vous vos capsules ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Cette information nous permettra de mieux adapter la fréquence d\'envoi des capsules.',),
                    gapHNormal,
                    Column(
                      children: [
                        for (var option in const ['day', 'week', 'month']) Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: value['recurrence'] == option ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.inverseSurface,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text(recurrenceOptions[option]),
                                onTap: () => setRecurrence('recurrence', option),
                              ),
                            ),
                            gapHNormal,
                          ],
                        )
                      ]
                    ),
                  ]
                )
              ),
            ),
            gapHNormal,
            Text('Données.', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Supprimer toutes les données', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  AppInfoMessage(message: 'Cette action supprimera définitivement toutes vos capsules et moments enregistrés. Cette action est irréversible.'),
                  gapHNormal,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showDeleteConfirmationDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.trash, color: Theme.of(context).colorScheme.surface, size: 15),
                          gapWNormal,
                          Text('Supprimer toutes les données', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            gapHNormal,
            ElevatedButton(
              onPressed: () async {
                print('clear moments');
                await ref.read(sharedPreferencesProvider).setStringList('moments', []);
                SnackBar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  content: Text('Tous les moments ont été supprimés.', style: Theme.of(context).textTheme.bodyMedium),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.trash, color: Theme.of(context).colorScheme.surface, size: 15),
                  gapWNormal,
                  Text('Supprimer les capsules', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                ],
              ),
            )
          ]
        )
      )
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text('Confirmer la suppression', style: Theme.of(context).textTheme.titleLarge),
          content: Text(
            'Êtes-vous sûr de vouloir supprimer toutes vos capsules et moments ? Cette action est irréversible.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
            ),
            ElevatedButton(
              onPressed: () async {
                await ref.read(capsuleRepositoryProvider).clearAllData();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      content: Text('Toutes les données ont été supprimées.', style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.trash, color: Theme.of(context).colorScheme.surface, size: 15),
                  gapWNormal,
                  Text('Supprimer', style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
