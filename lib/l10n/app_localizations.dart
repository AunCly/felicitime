import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get hello;

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'Lang'**
  String get lang;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Be careful !'**
  String get warning;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'Voir tout'**
  String get viewAll;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// No description provided for @goodDay.
  ///
  /// In en, this message translates to:
  /// **'Hey, welcome'**
  String get goodDay;

  /// No description provided for @wantPlay.
  ///
  /// In en, this message translates to:
  /// **'What do you want to play?'**
  String get wantPlay;

  /// No description provided for @findGame.
  ///
  /// In en, this message translates to:
  /// **'Search for a game'**
  String get findGame;

  /// No description provided for @addGame.
  ///
  /// In en, this message translates to:
  /// **'Add a game'**
  String get addGame;

  /// No description provided for @addGameDescription.
  ///
  /// In en, this message translates to:
  /// **'Add photos of the rules of the game, and try to take clear, sharp photos so that we can analyse them properly.'**
  String get addGameDescription;

  /// No description provided for @lastGameAdded.
  ///
  /// In en, this message translates to:
  /// **'Last game added'**
  String get lastGameAdded;

  /// No description provided for @seeGameList.
  ///
  /// In en, this message translates to:
  /// **'See the list of games'**
  String get seeGameList;

  /// No description provided for @howCanHelpYou.
  ///
  /// In en, this message translates to:
  /// **'How can I help you?'**
  String get howCanHelpYou;

  /// No description provided for @updateSettings.
  ///
  /// In en, this message translates to:
  /// **'Modify my settings'**
  String get updateSettings;

  /// No description provided for @yourNicestName.
  ///
  /// In en, this message translates to:
  /// **'Your prettiest name'**
  String get yourNicestName;

  /// No description provided for @yourBuddy.
  ///
  /// In en, this message translates to:
  /// **'Your mascot'**
  String get yourBuddy;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @colorScheme.
  ///
  /// In en, this message translates to:
  /// **'Color scheme'**
  String get colorScheme;

  /// No description provided for @greenScheme.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get greenScheme;

  /// No description provided for @blueScheme.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blueScheme;

  /// No description provided for @redScheme.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get redScheme;

  /// No description provided for @purpleScheme.
  ///
  /// In en, this message translates to:
  /// **'Purple'**
  String get purpleScheme;

  /// No description provided for @gameResume.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get gameResume;

  /// No description provided for @questionRules.
  ///
  /// In en, this message translates to:
  /// **'Question about the rules'**
  String get questionRules;

  /// No description provided for @rulesPictures.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get rulesPictures;

  /// No description provided for @rulesText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get rulesText;

  /// No description provided for @resumeText.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeText;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Game rules'**
  String get rules;

  /// No description provided for @formatRules.
  ///
  /// In en, this message translates to:
  /// **'Formatting rules'**
  String get formatRules;

  /// No description provided for @gameTitle.
  ///
  /// In en, this message translates to:
  /// **'Game title'**
  String get gameTitle;

  /// No description provided for @resetTutorial.
  ///
  /// In en, this message translates to:
  /// **'Reset the tutorial'**
  String get resetTutorial;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Life is too short to read the rules'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your ludovik assistant, summarizes the rules of all your games and answers all your questions. No more disputes, no more wasted time!'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get onboardingSettingsTitle;

  /// No description provided for @onboardingSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your Vic to accompany you!'**
  String get onboardingSettingsSubtitle;

  /// No description provided for @onboardingVictoire.
  ///
  /// In en, this message translates to:
  /// **'Victoire plays for fun. Never a sore loser, she loves games of speed and reflection.'**
  String get onboardingVictoire;

  /// No description provided for @onboardingVictor.
  ///
  /// In en, this message translates to:
  /// **'Victor plays for fun but also to win. He loves strategy games.'**
  String get onboardingVictor;

  /// No description provided for @onboardingChooseName.
  ///
  /// In en, this message translates to:
  /// **'Choose your prettiest name:'**
  String get onboardingChooseName;

  /// No description provided for @onboardingSearchGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Search for a game'**
  String get onboardingSearchGameTitle;

  /// No description provided for @onboardingSearchGameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hello, my name is {mascot}, thank you for choosing me, we are going to have fun! \n\nA game of Cubirds, anyone? Let\'s see if a user has already added it!'**
  String onboardingSearchGameSubtitle(Object mascot);

  /// No description provided for @onboardingAddGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a game'**
  String get onboardingAddGameTitle;

  /// No description provided for @onboardingAddGameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Oh no, it doesn\'t exist in our database!\n\nDon\'t panic, this time I\'ll add it for you.'**
  String get onboardingAddGameSubtitle;

  /// No description provided for @onboardingAddGameOne.
  ///
  /// In en, this message translates to:
  /// **'Adding the main image'**
  String get onboardingAddGameOne;

  /// No description provided for @onboardingAddGameTwo.
  ///
  /// In en, this message translates to:
  /// **'Roll the dice: Extra action!'**
  String get onboardingAddGameTwo;

  /// No description provided for @onboardingAddGameThree.
  ///
  /// In en, this message translates to:
  /// **'Generation of rules'**
  String get onboardingAddGameThree;

  /// No description provided for @onboardingAddGameFour.
  ///
  /// In en, this message translates to:
  /// **'Feeding the birds'**
  String get onboardingAddGameFour;

  /// No description provided for @onboardingAddGameFive.
  ///
  /// In en, this message translates to:
  /// **'Adding additional images'**
  String get onboardingAddGameFive;

  /// No description provided for @onboardingAddGameVoila.
  ///
  /// In en, this message translates to:
  /// **'And here we go!'**
  String get onboardingAddGameVoila;

  /// No description provided for @onboardingGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Play a game'**
  String get onboardingGameTitle;

  /// No description provided for @onboardingGameKnowHowToPlay.
  ///
  /// In en, this message translates to:
  /// **'Let\'s go! By the way, do you know how to play?'**
  String get onboardingGameKnowHowToPlay;

  /// No description provided for @onboardingGameKnowHowToPlayNo.
  ///
  /// In en, this message translates to:
  /// **'Nope'**
  String get onboardingGameKnowHowToPlayNo;

  /// No description provided for @onboardingGameKnowHowToPlayYes.
  ///
  /// In en, this message translates to:
  /// **'Of course'**
  String get onboardingGameKnowHowToPlayYes;

  /// No description provided for @onboardingGameKnowHowToPlayNoResume.
  ///
  /// In en, this message translates to:
  /// **'No worries, I\'ll explain everything to you!'**
  String get onboardingGameKnowHowToPlayNoResume;

  /// No description provided for @onboardingGameKnowHowToPlayNoSeeResume.
  ///
  /// In en, this message translates to:
  /// **'See the summary'**
  String get onboardingGameKnowHowToPlayNoSeeResume;

  /// No description provided for @onboardingGameStartPlaying.
  ///
  /// In en, this message translates to:
  /// **'Great! Let\'s get started, but I\'m not sure how many birds to collect when playing with two players?'**
  String get onboardingGameStartPlaying;

  /// No description provided for @onboardingGameStartPlayingQuestion.
  ///
  /// In en, this message translates to:
  /// **'How many birds do you need to collect to finish the game?'**
  String get onboardingGameStartPlayingQuestion;

  /// No description provided for @onboardingGameStartPlayingAskQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask the question'**
  String get onboardingGameStartPlayingAskQuestion;

  /// No description provided for @onboardingGameStartPlayingAnswer.
  ///
  /// In en, this message translates to:
  /// **'You need to collect 7 different birds or 3 birds from 2 families to finish the game!'**
  String get onboardingGameStartPlayingAnswer;

  /// No description provided for @onboardingGameStartPlayingGo.
  ///
  /// In en, this message translates to:
  /// **'That\'s what I thought, we can play now!'**
  String get onboardingGameStartPlayingGo;

  /// No description provided for @onboardingThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get onboardingThanks;

  /// No description provided for @onboardingThanksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You are now ready to play, have fun!'**
  String get onboardingThanksSubtitle;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @questionMissing.
  ///
  /// In en, this message translates to:
  /// **'Please ask a question'**
  String get questionMissing;

  /// No description provided for @questionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Your question'**
  String get questionPlaceholder;

  /// No description provided for @askQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a question'**
  String get askQuestion;

  /// No description provided for @mascotKnowTheRules.
  ///
  /// In en, this message translates to:
  /// **'I know all the rules of {game}!'**
  String mascotKnowTheRules(Object game);

  /// No description provided for @notAGame.
  ///
  /// In en, this message translates to:
  /// **'Error: according to what you have provided us, we do not detect a board game.'**
  String get notAGame;

  /// No description provided for @takePictures.
  ///
  /// In en, this message translates to:
  /// **'Take pictures'**
  String get takePictures;

  /// No description provided for @gameCreationDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a game to the database, so that you can obtain a summary of the rules and start asking questions about them.'**
  String get gameCreationDescription;

  /// No description provided for @gameListeEmpty.
  ///
  /// In en, this message translates to:
  /// **'The list of games is empty, add a game to start playing!'**
  String get gameListeEmpty;

  /// No description provided for @onboardingGameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cubirds'**
  String get onboardingGameDialogTitle;

  /// No description provided for @onboardingGameDialogResume.
  ///
  /// In en, this message translates to:
  /// **'Cubirds is a game of observation and strategy. The goal is to collect the most points by observing the birds on the cards and placing them in the right order. The game ends when a player has placed all his cards or when the deck is empty. The player with the most points wins the game.'**
  String get onboardingGameDialogResume;

  /// No description provided for @onboardingGameDialogClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get onboardingGameDialogClose;

  /// No description provided for @gameResumeNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'The summary of the rules is not available, please add it.'**
  String get gameResumeNotAvailable;

  /// No description provided for @errorAppend.
  ///
  /// In en, this message translates to:
  /// **'Une erreur est survenue, veuillez réessayer.'**
  String get errorAppend;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
