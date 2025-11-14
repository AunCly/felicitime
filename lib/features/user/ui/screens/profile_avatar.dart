import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/config/colors.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/main.dart';

class AvatarScreen extends ConsumerStatefulWidget {
  const AvatarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ConsumerState<AvatarScreen> {

  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = ref.read(sharedPreferencesProvider).getInt('avatar') ?? 0;
  }

  _selectAvatar(int index) {
    setState(() {
      selected = index;
    });
    ref.read(sharedPreferencesProvider).setInt('avatar', index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Prenez celui qui qui vous ressemble, ou vous amuse le plus !', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
              gapHNormal,
              gapHNormal,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _selectAvatar(1),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: selected == 1 ? Border.all(color: Theme.of(context).colorScheme.secondary, width: 4) : null,
                        image: const DecorationImage(
                          image: AssetImage('images/victor.png'),
                          fit: BoxFit.cover,
                        ),
                        color: AppColors.appWhite,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  gapWLarge,
                  GestureDetector(
                    onTap: () => _selectAvatar(2),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: selected == 2 ? Border.all(color: Theme.of(context).colorScheme.secondary, width: 4) : null,
                        image: const DecorationImage(
                          image: AssetImage('images/victoire.png'),
                          fit: BoxFit.cover,
                        ),
                        color: AppColors.appWhite,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                ]
              ),
            ]
          )
        ),
      ],
    );
  }
}
