// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello, ';

  @override
  String get lang => 'Lang';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get settings => 'Settings';

  @override
  String get warning => 'Be careful !';

  @override
  String get camera => 'Camera';

  @override
  String get images => 'Images';

  @override
  String get next => 'Next';

  @override
  String get french => 'French';

  @override
  String get english => 'English';

  @override
  String get add => 'Add';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get noImageSelected => 'No image selected';

  @override
  String get goodDay => 'Hey, welcome';

  @override
  String get wantPlay => 'What do you want to play?';

  @override
  String get findGame => 'Search for a game';

  @override
  String get addGame => 'Add a game';

  @override
  String get addGameDescription =>
      'Add photos of the rules of the game, and try to take clear, sharp photos so that we can analyse them properly.';

  @override
  String get lastGameAdded => 'Last game added';

  @override
  String get seeGameList => 'See the list of games';

  @override
  String get howCanHelpYou => 'How can I help you?';

  @override
  String get updateSettings => 'Modify my settings';

  @override
  String get yourNicestName => 'Your prettiest name';

  @override
  String get yourBuddy => 'Your mascot';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get colorScheme => 'Color scheme';

  @override
  String get greenScheme => 'Green';

  @override
  String get blueScheme => 'Blue';

  @override
  String get redScheme => 'Red';

  @override
  String get purpleScheme => 'Purple';

  @override
  String get gameResume => 'Summary';

  @override
  String get questionRules => 'Question about the rules';

  @override
  String get rulesPictures => 'Photos';

  @override
  String get rulesText => 'Text';

  @override
  String get resumeText => 'Resume';

  @override
  String get rules => 'Game rules';

  @override
  String get formatRules => 'Formatting rules';

  @override
  String get gameTitle => 'Game title';

  @override
  String get resetTutorial => 'Reset the tutorial';

  @override
  String get onboardingTitle => 'Life is too short to read the rules';

  @override
  String get onboardingSubtitle =>
      'Your ludovik assistant, summarizes the rules of all your games and answers all your questions. No more disputes, no more wasted time!';

  @override
  String get onboardingSettingsTitle => 'Settings';

  @override
  String get onboardingSettingsSubtitle => 'Choose your Vic to accompany you!';

  @override
  String get onboardingVictoire =>
      'Victoire plays for fun. Never a sore loser, she loves games of speed and reflection.';

  @override
  String get onboardingVictor =>
      'Victor plays for fun but also to win. He loves strategy games.';

  @override
  String get onboardingChooseName => 'Choose your prettiest name:';

  @override
  String get onboardingSearchGameTitle => 'Search for a game';

  @override
  String onboardingSearchGameSubtitle(Object mascot) {
    return 'Hello, my name is $mascot, thank you for choosing me, we are going to have fun! \n\nA game of Cubirds, anyone? Let\'s see if a user has already added it!';
  }

  @override
  String get onboardingAddGameTitle => 'Add a game';

  @override
  String get onboardingAddGameSubtitle =>
      'Oh no, it doesn\'t exist in our database!\n\nDon\'t panic, this time I\'ll add it for you.';

  @override
  String get onboardingAddGameOne => 'Adding the main image';

  @override
  String get onboardingAddGameTwo => 'Roll the dice: Extra action!';

  @override
  String get onboardingAddGameThree => 'Generation of rules';

  @override
  String get onboardingAddGameFour => 'Feeding the birds';

  @override
  String get onboardingAddGameFive => 'Adding additional images';

  @override
  String get onboardingAddGameVoila => 'And here we go!';

  @override
  String get onboardingGameTitle => 'Play a game';

  @override
  String get onboardingGameKnowHowToPlay =>
      'Let\'s go! By the way, do you know how to play?';

  @override
  String get onboardingGameKnowHowToPlayNo => 'Nope';

  @override
  String get onboardingGameKnowHowToPlayYes => 'Of course';

  @override
  String get onboardingGameKnowHowToPlayNoResume =>
      'No worries, I\'ll explain everything to you!';

  @override
  String get onboardingGameKnowHowToPlayNoSeeResume => 'See the summary';

  @override
  String get onboardingGameStartPlaying =>
      'Great! Let\'s get started, but I\'m not sure how many birds to collect when playing with two players?';

  @override
  String get onboardingGameStartPlayingQuestion =>
      'How many birds do you need to collect to finish the game?';

  @override
  String get onboardingGameStartPlayingAskQuestion => 'Ask the question';

  @override
  String get onboardingGameStartPlayingAnswer =>
      'You need to collect 7 different birds or 3 birds from 2 families to finish the game!';

  @override
  String get onboardingGameStartPlayingGo =>
      'That\'s what I thought, we can play now!';

  @override
  String get onboardingThanks => 'Thank you!';

  @override
  String get onboardingThanksSubtitle => 'You are now ready to play, have fun!';

  @override
  String get onboardingNext => 'Next';

  @override
  String get questionMissing => 'Please ask a question';

  @override
  String get questionPlaceholder => 'Your question';

  @override
  String get askQuestion => 'Ask a question';

  @override
  String mascotKnowTheRules(Object game) {
    return 'I know all the rules of $game!';
  }

  @override
  String get notAGame =>
      'Error: according to what you have provided us, we do not detect a board game.';

  @override
  String get takePictures => 'Take pictures';

  @override
  String get gameCreationDescription =>
      'Add a game to the database, so that you can obtain a summary of the rules and start asking questions about them.';

  @override
  String get gameListeEmpty =>
      'The list of games is empty, add a game to start playing!';

  @override
  String get onboardingGameDialogTitle => 'Cubirds';

  @override
  String get onboardingGameDialogResume =>
      'Cubirds is a game of observation and strategy. The goal is to collect the most points by observing the birds on the cards and placing them in the right order. The game ends when a player has placed all his cards or when the deck is empty. The player with the most points wins the game.';

  @override
  String get onboardingGameDialogClose => 'Close';

  @override
  String get gameResumeNotAvailable =>
      'The summary of the rules is not available, please add it.';

  @override
  String get errorAppend => 'Une erreur est survenue, veuillez réessayer.';
}
