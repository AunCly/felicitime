// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get hello => 'Bonjour, ';

  @override
  String get lang => 'Langue';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get settings => 'Réglages';

  @override
  String get warning => 'Attention !';

  @override
  String get camera => 'Camera';

  @override
  String get images => 'Images';

  @override
  String get next => 'Continuer';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get add => 'Ajouter';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get noImageSelected => 'Aucune image sélectionnée';

  @override
  String get goodDay => 'Bien le bonjour';

  @override
  String get wantPlay => 'A quoi voulez vous jouer ?';

  @override
  String get findGame => 'Rechercher un jeu';

  @override
  String get addGame => 'Ajouter un jeu';

  @override
  String get addGameDescription =>
      'Ajoutez les photos des règles du jeu, essayez de prendre des photos nettes, et claires afin que nous puissions les analyser correctement.';

  @override
  String get lastGameAdded => 'Derniers jeux ajoutés';

  @override
  String get seeGameList => 'Voir la liste des jeux';

  @override
  String get howCanHelpYou => 'Comment puis-je vous aider ?';

  @override
  String get updateSettings => 'Modifier mes paramètres';

  @override
  String get yourNicestName => 'Votre plus joli prénom';

  @override
  String get yourBuddy => 'Votre mascotte';

  @override
  String get lightTheme => 'Thème clair';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get colorScheme => 'Schéma de couleur';

  @override
  String get greenScheme => 'Vert';

  @override
  String get blueScheme => 'Bleu';

  @override
  String get redScheme => 'Rouge';

  @override
  String get purpleScheme => 'Violet';

  @override
  String get gameResume => 'Résumé des règles';

  @override
  String get questionRules => 'Question sur les règles';

  @override
  String get rulesPictures => 'Photos';

  @override
  String get rulesText => 'Texte';

  @override
  String get resumeText => 'Résumé';

  @override
  String get rules => 'Règles du jeu';

  @override
  String get formatRules => 'Formater les règles';

  @override
  String get gameTitle => 'Titre du jeu';

  @override
  String get resetTutorial => 'Réinitialiser le tutoriel';

  @override
  String get onboardingTitle => 'La vie est trop courte pour lire les règles';

  @override
  String get onboardingSubtitle =>
      'Votre assistant Ludovik, résume les règles de tous vos jeux en un clin d\'oeil et répond à toutes vos questions. Plus de dispute, plus de temps perdu !';

  @override
  String get onboardingSettingsTitle => 'Paramétrage';

  @override
  String get onboardingSettingsSubtitle =>
      'Choisissez votre Vic pour vous accompagner !';

  @override
  String get onboardingVictoire =>
      'Victoire joue pour s\'amuser. Jamais mauvaise perdante elle adore les jeux de rapidité et de réflexion.';

  @override
  String get onboardingVictor =>
      'Victor joue pour s\'amuser mais surtout pour gagner. Les jeux de stratégie, il adore ça.';

  @override
  String get onboardingChooseName => 'Donnez nous votre plus beau prénom :';

  @override
  String get onboardingSearchGameTitle => 'Chercher un jeu';

  @override
  String onboardingSearchGameSubtitle(Object mascot) {
    return 'Hello, moi c\'est $mascot, merci on va bien s\'amuser ! \n\nUne partie de Cubirds ça vous dit ? Voyons si un utilisateur l\'a déjà ajouté !';
  }

  @override
  String get onboardingAddGameTitle => 'Ajouter un jeu';

  @override
  String get onboardingAddGameSubtitle =>
      'Oh non il n\'existe pas dans notre base de données !\n\nPas de panique, cette fois ci je vais l\'ajouter pour vous.';

  @override
  String get onboardingAddGameOne => 'Ajout de l\'image principale';

  @override
  String get onboardingAddGameTwo => 'Jet de dée : Action supplémentaire !';

  @override
  String get onboardingAddGameThree => 'Génération des règles';

  @override
  String get onboardingAddGameFour => 'Nourissage des oiseaux';

  @override
  String get onboardingAddGameFive => 'Ajout des images supplémentaires';

  @override
  String get onboardingAddGameVoila => 'Et voilaaaaa !';

  @override
  String get onboardingGameTitle => 'Jouer à un jeu';

  @override
  String get onboardingGameKnowHowToPlay =>
      'C\'est parti ! Au fait vous savez jouer ?';

  @override
  String get onboardingGameKnowHowToPlayNo => 'Nope';

  @override
  String get onboardingGameKnowHowToPlayYes => 'Bien sûr';

  @override
  String get onboardingGameKnowHowToPlayNoResume =>
      'Pas de soucis, je vous explique tout !';

  @override
  String get onboardingGameKnowHowToPlayNoSeeResume => 'Voir le résumé';

  @override
  String get onboardingGameStartPlaying =>
      'Super ! On peux commencer mais j\'ai un doute combien faut il collectionner d\'oiseaux lorsque l\'on joue a deux ?';

  @override
  String get onboardingGameStartPlayingQuestion =>
      'Combien d\'oiseau faut il collectionner pour terminer la partie ?';

  @override
  String get onboardingGameStartPlayingAskQuestion => 'Poser la question';

  @override
  String get onboardingGameStartPlayingAnswer =>
      'Il faut collectionner 7 oiseaux différents ou 3 oiseaux de 2 familles pour terminer la partie !';

  @override
  String get onboardingGameStartPlayingGo =>
      'C\'est bien ce que je pensais on peut jouer maitenant !';

  @override
  String get onboardingThanks => 'Merci !';

  @override
  String get onboardingThanksSubtitle =>
      'Merci d\'avoir suivi cette courte introduction, à vous de jouer maintenant.';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get questionMissing => 'Veuillez poser une question';

  @override
  String get questionPlaceholder => 'Votre question';

  @override
  String get askQuestion => 'Poser une question';

  @override
  String mascotKnowTheRules(Object game) {
    return 'Je suis incollable sur les règles de $game !';
  }

  @override
  String get notAGame =>
      'Erreur : D\'après ce que vous nous avez fourni, nous ne détectons pas de jeu de société.';

  @override
  String get takePictures => 'Prendre des photos';

  @override
  String get gameCreationDescription =>
      'Ajouter un jeu à la base de données, afin de pouvoir obtenir un résumé des règles et commencer à poser des questions sur les règles.';

  @override
  String get gameListeEmpty =>
      'La liste des jeux est vide, ajoutez un jeu pour commencer à jouer.';

  @override
  String get onboardingGameDialogTitle => 'Cubirds';

  @override
  String get onboardingGameDialogResume =>
      'Cubirds est un jeu de cartes dans lequel les joueurs doivent collecter des oiseaux pour marquer des points. Les joueurs peuvent choisir de prendre des cartes oiseaux ou de les échanger contre des cartes objectifs. Le jeu se termine lorsque la pioche est vide et le joueur avec le plus de points gagne.';

  @override
  String get onboardingGameDialogClose => 'Fermer';

  @override
  String get gameResumeNotAvailable =>
      'Le résumé pour ce jeu n\'est pas encore disponible';

  @override
  String get errorAppend => 'Une erreur est survenue, veuillez réessayer.';
}
