import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sight_reading_app/screens/achievements_screen.dart';
import 'package:sight_reading_app/screens/endless_mode_screen.dart';
import 'package:sight_reading_app/screens/note_helper_menu_screen.dart';
import 'package:sight_reading_app/screens/lesson_menu_screen.dart';
import 'package:sight_reading_app/screens/menu_screen.dart';
import 'package:sight_reading_app/screens/practice_screen.dart';
import 'package:sight_reading_app/screens/random_quiz_screen.dart';
import 'package:sight_reading_app/screens/settings_screen.dart';
import 'package:sight_reading_app/storage_reader_writer.dart';
import 'package:sight_reading_app/theme_listener.dart';
import 'package:provider/provider.dart';
import 'package:sight_reading_app/screens/play_along_menu_screen.dart';
import 'package:sight_reading_app/screens/speedrun_menu_screen.dart';
import 'package:sight_reading_app/screens/quiz_selection_screen.dart';

/// Runs the app after performing some checks.
void main() {
  // Starting the app in landscape orientation
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((value) => runApp(const SightReadingApp()));
}

/// The main root of the app.
class SightReadingApp extends StatelessWidget {
  const SightReadingApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    StorageReaderWriter().loadDataFromStorage();
    return ChangeNotifierProvider(
      // Changes the theme
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier themeNotifier, child) {
          return MaterialApp(
            title: 'Read That Sheet',
            theme: themeNotifier.convertThemeToThemeData(),
            debugShowCheckedModeBanner: false,
            initialRoute: MenuScreen.id,
            routes: {
              MenuScreen.id: (context) => const MenuScreen(),
              LessonMenuScreen.id: (context) => const LessonMenuScreen(),
              PracticeScreen.id: (context) => const PracticeScreen(),
              PlayAlongMenuScreen.id: (context) => const PlayAlongMenuScreen(),
              SpeedrunMenuScreen.id: (context) => const SpeedrunMenuScreen(),
              QuizSelectionScreen.id: (context) => const QuizSelectionScreen(),
              AchievementsScreen.id: (context) => const AchievementsScreen(),
              SettingsScreen.id: (context) => const SettingsScreen(),
              EndlessModeScreen.id: (context) => const EndlessModeScreen(),
              RandomQuizScreen.id: (context) => const RandomQuizScreen(),
              NoteHelperMenuScreen.id: (context) =>
                  const NoteHelperMenuScreen(),
            },
          );
        },
      ),
    );
  }
}
