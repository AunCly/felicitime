import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:felicitime/features/user/data/user_repository.dart';

class AppBottomBar extends ConsumerWidget {

  AppBottomBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  final List _classicMenu = [
    {
      'index': 0,
      'icon': FontAwesomeIcons.lightCastle,
      'iconActive': FontAwesomeIcons.solidCastle,
      'label': 'Accueil',
      'route': '/dashboard',
    },
    {
      'index': 1,
      'icon': FontAwesomeIcons.lightGameBoard,
      'iconActive': FontAwesomeIcons.solidGameBoard,
      'label': 'Jeux',
      'route': '/games',
    },
    {
      'index': 2,
      'icon': FontAwesomeIcons.lightBookFont,
      'iconActive': FontAwesomeIcons.solidBookFont,
      'label': 'Mes jeux',
      'route': '/me/games',
    },
    {
      'index': 3,
      'icon': FontAwesomeIcons.lightScrewdriverWrench,
      'iconActive': FontAwesomeIcons.solidScrewdriverWrench,
      'label': 'Parties',
      'route': '/parties',
    },
  ];

  int _computeIndex() {
    String location = GoRouterState.of(context).uri.toString();
    if (location == '/dashboard') {
      return 0;
    } else if (location.startsWith('/games')) {
      return 1;
    } else if (location == '/me/games') {
      return 2;
    } else if (location == '/parties') {
      return 3;
    } else {
      return 0;
    }
  }

  List<BottomNavigationBarItem> _menuItems(){
    List<BottomNavigationBarItem> menuItemsList = [];
    List menu = _classicMenu;

    for (var element in menu) {
      menuItemsList.add(
        BottomNavigationBarItem(
          icon: Icon(element['icon'], color: Theme.of(context).colorScheme.primary),
          activeIcon: Icon(element['iconActive'], color: Theme.of(context).colorScheme.secondary),
          label : element['label'],
        ),
      );
    }

    return menuItemsList;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AsyncValue me = ref.watch(getMeStreamProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.shadow,
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        items: _menuItems(),
        currentIndex: _computeIndex(),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedLabelStyle: GoogleFonts.solway(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary
        ),
        selectedLabelStyle: GoogleFonts.solway(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary
        ),
        enableFeedback: true,
        onTap: (index) {
          GoRouter.of(context).go(_classicMenu[index]['route']);
        },
      ),
    );
  }
}
