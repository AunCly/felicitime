import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:felicitime/features/user/ui/controllers/settings_controller.dart';
import 'package:felicitime/services/notification.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:felicitime/ui/widgets/info_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends ConsumerState<SettingsScreen> {

  Map familyOptions = {
    'yes': 'Oui',
    'near': 'Oui a quelques minutes',
    'no': 'Non',
    'all_family': 'Ne souhaite pas répondre',
  };

  Map priceOptions = {
    'yes': 'Oui',
    'low': 'Quelques euros',
    'free': 'Non',
    'all_price': 'Ne souhaite pas répondre',
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
    final service = NotificationService();
    await service.cancelCapsuleNotification();
    await service.scheduleCapsuleNotification();
    await ref.read(settingsControllerProvider.notifier).setSettings(key, value);
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
                  children: [
                    Text('Voulez-vous activer les notifications ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Vous recevrez une notification par jour pour le suivi d\'humeur et une notification pour votre capsule selon la réccurence que vous avez défini(e), pas une de plus.',),
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
                    AppInfoMessage(message: 'Ces informations nous permettent de mieux adapter nos suggestions en fonction de votre situation géographique et sociale.',),
                    gapHNormal,
                    Column(
                      children: [
                        for(var option in const ['yes', 'near', 'no', 'all_family']) Column(
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
                    Text('Acceptez vous de dépenser quelques euros pour une capsule ?', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Cette information permettra à l\'application de vous suggérer uniquement des capsules qui correspondent à votre situation financière.',),
                    gapHNormal,
                    Column(
                      children: [
                        for (var option in const ['yes', 'low', 'free', 'all_price']) Column(
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
                    Text('A quelle récurrence souhaitez vous vos capsules', style: Theme.of(context).textTheme.titleMedium),
                    gapHNormal,
                    AppInfoMessage(message: 'Cette information nous permettra de mieux adapter la fréquence d\'envoi des capsules en fonction de vos préférences.',),
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
          ]
        )
      )
    );
  }
}
