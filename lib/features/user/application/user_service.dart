import 'package:flutter/material.dart';
import 'package:felicitime/features/user/model/user.dart';
import 'package:felicitime/features/user/ui/screens/profile_avatar.dart';
import 'package:felicitime/features/user/ui/screens/profile_informations.dart';
import 'package:felicitime/ui/widgets/dialog.dart';

class UserService {

  static void showProfilInformationsModelDialog(BuildContext context, User user){
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) => Dialog.fullscreen(
        child: AppDialog(
          title: 'Informations personnelles',
          content: ProfilInformations(),
        )
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  static void showAvatarDialog(BuildContext context){
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) => const Dialog.fullscreen(
          child: AppDialog(
            title: 'Changer l\'avatar',
            content: AvatarScreen(),
          )
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

}