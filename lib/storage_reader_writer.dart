import 'package:flutter/material.dart';
//import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sight_reading_app/constants.dart';
import 'package:sight_reading_app/helper.dart';
import 'package:sight_reading_app/lessons_and_quizzes/question_answer_data.dart';
import 'package:sight_reading_app/lessons_and_quizzes/questions.dart';
import 'package:sight_reading_app/screens/play_along_menu_screen.dart';

import 'constants.dart';

/// Writes data to storage
class StorageReaderWriter {
  /// The key-value pairs to store in memory
  final Map _map = {};

  /// Constructor
  StorageReaderWriter() {
    _setDefaultSettings();
    _areValuesInStorage();
  }

  /// If there are no values in storage it sets everything to default values
  void _areValuesInStorage() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getKeys().isEmpty) {
      reset();
    }
  }

  /// Gets the value using the key in [_map]
  Object? read(String key) {
    return _map[key];
  }

  /// Writes the key-value pair to storage
  Future<void> write(String key, Object value) async {
    // Key: lesson name
    // Value: score
    // Format: 'lesson 1' -> 3
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _map[key] = value.toString();
    await pref.setString(key, value.toString());
    if (key == 'volume') {
      // TODO: Figure out why this doesn't work
      // PerfectVolumeControl.setVolume(
      //     double.parse(value.toString()) / 100); //Needs values from 0 to 1
    }
  }

  /// Resets the StorageWriter back to the defaults
  void reset() {
    _setDefaultValues();
    _writeDefaultsToStorage();
    _setDefaultSettings();
    _writeDefaultSettingsToStorage();
    _resetLessons();
    //_resetAchievements();
    _resetQuizzes();
  }

  /// Puts default values into the map
  void _setDefaultValues() {
    // _map['volume'] = constants.defaultVolumeLevel;
    // _map['difficulty'] = constants.defaultDifficultyLevel;
    // With 7 lessons:

    for (int i = 1; i <= 7; ++i) {
      _map['lesson $i'] = 0;
    }

    _setDefaultEndlessRecords();
    _setDefaultPlayAlongRecords();
  }

  /// Writes the default StorageWriter values to Shared Preferences
  Future<void> _writeDefaultsToStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setInt('volume', constants.defaultVolumeLevel);
    // pref.setString('difficulty', constants.defaultDifficultyLevel);
    for (int i = 1; i <= 7; ++i) {
      pref.setString('lesson $i', '0');
    }
    _writeEndlessRecordsToStorage();
    _writePlayAlongRecordsToStorage();
  }

  /// Loads the StorageWriter from Shared Preferences
  Future<void> loadDataFromStorage() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await _loadSettingsFromStorage(pref);
    await loadLessonScoresFromStorage(pref);
    await loadQuestionAnswerDataFromStorage(pref);
    await _loadEndlessRecordsFromStorage(pref);
    await _loadPlayAlongRecordsFromStorage(pref);
    await _loadSpeedrunRecordsFromStorage(pref);
    await _loadQuizRecordsFromStorage(pref);
  }

  Future<void> loadLessonScoresFromStorage(SharedPreferences pref) async {
    String? isOnDisk = pref.getString('lesson 1');
    if (isOnDisk == null) {
      _setDefaultValues();
      await _writeDefaultsToStorage();
    } else {
      for (int i = 1; i <= 7; ++i) {
        String? lessonScore = pref.getString('lesson $i');
        if (lessonScore != null) _map['lesson $i'] = lessonScore;
      }
    }
  }

  Future<void> loadQuestionAnswerDataFromStorage(SharedPreferences pref) async {
    int? isOnDisk = pref.getInt('questionID 1');
    if (isOnDisk == null) {
      QuestionAnswerData.createDefaultMap();
    } else {
      for (int i = 1; i <= questions.length; ++i) {
        String? questionStatistic = pref.getString('questionID $i');
        if (questionStatistic != null) {
          _map['questionID $i'] = questionStatistic;
          QuestionAnswerData.updateQuestionStatisticsMap(
            i,
            int.parse(questionStatistic),
          );
        }
      }
    }
  }

  Future<Map<String, int>> loadAchievementValues() async {
    final prefs = await SharedPreferences.getInstance();
    // int completedLessons = (prefs.getInt('completed_lessons') ?? 0);
    // int completedQuizzes = (prefs.getInt('completed_quizzes') ?? 0);
    // int endlessBassHS =
    //     int.parse(prefs.getString('endless-bass-${prefs.get('difficulty').toString().toLowerCase()}-high-score') ?? '0');
    // int endlessTrebleHS =
    //     int.parse(prefs.getString('endless-treble-${prefs.get('difficulty').toString().toLowerCase()}-high-score') ?? '0');

    int lessonsPassed = 0;

    for (int x = 0; x < numOfLessons; x++) {
      bool value = prefs.getBool('lesson-num-$x') ?? false;
      if (value) lessonsPassed += 1;
      //print('adding the $x one');
    }
    //print("current lessons passed: $lessonsPassed");

    //int completedLessons = (prefs.getInt('completed_lessons') ?? 0);
    int completedQuizzes = (prefs.getInt('completed_quizzes') ?? 0);
    int endlessBassBegHS =
        int.parse(prefs.getString('endless-bass-beginner-high-score') ?? '0');
    int endlessBassInterHS = int.parse(
        prefs.getString('endless-bass-intermediate-high-score') ?? '0');
    int endlessBassExpHS =
        int.parse(prefs.getString('endless-bass-expert-high-score') ?? '0');

    int endlessTrebleBegHS =
        int.parse(prefs.getString('endless-treble-beginner-high-score') ?? '0');
    int endlessTrebleInterHS = int.parse(
        prefs.getString('endless-treble-intermediate-high-score') ?? '0');
    int endlessTrebleExpHS =
        int.parse(prefs.getString('endless-treble-expert-high-score') ?? '0');

    int speedrun10HS = prefs.getInt('10_second_speedrun_record') ?? 0;
    int speedrun20HS = prefs.getInt('20_second_speedrun_record') ?? 0;
    int speedrun30HS = prefs.getInt('30_second_speedrun_record') ?? 0;
    int speedrun40HS = prefs.getInt('40_second_speedrun_record') ?? 0;
    int speedrun50HS = prefs.getInt('50_second_speedrun_record') ?? 0;
    int speedrun60HS = prefs.getInt('60_second_speedrun_record') ?? 0;

    Map<String, int> values = {
      'completedLessons': lessonsPassed,
      'completedQuizzes': completedQuizzes,
      'endlessBassBegHS': endlessBassBegHS,
      'endlessBassInterHS': endlessBassInterHS,
      'endlessBassExpHS': endlessBassExpHS,
      'endlessTrebleBegHS': endlessTrebleBegHS,
      'endlessTrebleInterHS': endlessTrebleInterHS,
      'endlessTrebleExpHS': endlessTrebleExpHS,
      'speedrun10HS': speedrun10HS,
      'speedrun20HS': speedrun20HS,
      'speedrun30HS': speedrun30HS,
      'speedrun40HS': speedrun40HS,
      'speedrun50HS': speedrun50HS,
      'speedrun60HS': speedrun60HS,
    };

    return values;
  }

  // //for lessons
  // Future<bool> isLessonComplete(lessonNum) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('lesson-num-$lessonNum', true);
  //   return prefs.getBool('lesson-num-$lessonNum') ?? true;
  // }

  Future<List<bool>> loadLessonValues() async {
    final prefs = await SharedPreferences.getInstance();
    List<bool> values = [];

    //prefs.setBool('lesson-num-1', false);

    for (int x = 0; x < numOfLessons; x++) {
      values.add(prefs.getBool('lesson-num-$x') ?? false);
      //print('adding the $x one');
    }
    //print(values);
    return values;
  }

  Future<void> saveCompletedLesson(lessonNum) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('lesson-num-$lessonNum', true);
    //print("lesson $lessonNum set to pass");
  }

  Future<void> saveCompletedQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    int completedQuizzes = (prefs.getInt('completed_quizzes') ?? 0);
    prefs.setInt('completed_quizzes', completedQuizzes + 1);
    //print("quiz passed and saved");
  }

  /// Loads endless records from storage
  Future<void> _loadEndlessRecordsFromStorage(SharedPreferences pref) async {
    String? isOnDisk = pref.getString('endless-treble-beginner-high-score');
    if (isOnDisk == null) {
      _setDefaultEndlessRecords();
      _writeEndlessRecordsToStorage();
    } else {
      for (String clef in <String>['treble', 'bass']) {
        for (Object difficulty in difficultyList) {
          String key =
              'endless-$clef-${difficulty.toString().toLowerCase()}-high-score';
          _map[key] = pref.getString(key);
        }
      }
    }
  }

  /// Sets the default endless records
  void _setDefaultEndlessRecords() {
    for (String clef in <String>['treble', 'bass']) {
      for (Object difficulty in difficultyList) {
        String key =
            'endless-$clef-${difficulty.toString().toLowerCase()}-high-score';
        _map[key] = '0';
      }
    }
  }

  /// Writes the endless records to storage
  void _writeEndlessRecordsToStorage() {
    for (String clef in <String>['treble', 'bass']) {
      for (Object difficulty in difficultyList) {
        String key =
            'endless-$clef-${difficulty.toString().toLowerCase()}-high-score';
        write(key, '0');
      }
    }
  }

  /// Loads play along records from storage
  Future<void> _loadPlayAlongRecordsFromStorage(SharedPreferences pref) async {
    String? isOnDisk =
        pref.getString('${trackNames[0].toLowerCase()}-${defaultDifficultyLevel.toLowerCase()}-high-score');
    if (isOnDisk == null) {
      _setDefaultPlayAlongRecords();
      _writePlayAlongRecordsToStorage();
    } else {
      for (String track in trackNames) {
        for (Object difficulty in difficultyList) {
          String key =
              '${track.toLowerCase()}-${difficulty.toString().toLowerCase()}-high-score';
          _map[key] = pref.get(key);
        }
      }
    }
  }

  /// Sets default play along records
  void _setDefaultPlayAlongRecords() {
    for (String track in trackNames) {
      for (Object difficulty in difficultyList) {
        String key =
            '${track.toLowerCase()}-${difficulty.toString().toLowerCase()}-high-score';
        _map[key] = '0';
      }
    }
  }

  /// Writes play along records to storage
  void _writePlayAlongRecordsToStorage() {
    for (String track in trackNames) {
      for (Object difficulty in difficultyList) {
        String key =
            '${track.toLowerCase()}-${difficulty.toString().toLowerCase()}-high-score';
        write(key, '0');
      }
    }
  }

  /// Loads speedrun records from storage
  Future<void> _loadSpeedrunRecordsFromStorage(SharedPreferences pref) async {
    Object? isOnDisk = pref.get('10_second_speedrun_record');
    if (isOnDisk == null) {
      _setDefaultSpeedrunRecords();
      _writeSpeedrunRecordsToStorage();
    } else {
        List<String> _modeRecordKeys = getRecordKeysForMode('speedrun');
        for (String key in _modeRecordKeys) {
          _map[key] = pref.get(key);
        }
    }
  }

  /// Sets default record values for the speedrun mode
  void _setDefaultSpeedrunRecords() {
    List<String> _modeRecordKeys = getRecordKeysForMode('speedrun');
    for (String key in _modeRecordKeys) {
      _map[key] = 0;
    }
  }

  /// Writes speedrun records to storage
  void _writeSpeedrunRecordsToStorage() {
    List<String> _modeRecordKeys = getRecordKeysForMode('speedrun');
    for (String key in _modeRecordKeys) {
      write(key, 0);
    }
  }

  /// Loads quiz records from storage
  Future<void> _loadQuizRecordsFromStorage(SharedPreferences pref) async {
    List<String> _quizRecordKeys = getRecordKeysForMode('quiz');
    Object? isOnDisk = pref.get(_quizRecordKeys[0]);
    if (isOnDisk == null) {
      _setDefaultQuizRecords();
      _writeQuizRecordsToStorage();
    } else {
      for (String key in _quizRecordKeys) {
          _map[key] = pref.get(key);
      }
    }
  }

  /// Sets the default records.
  void _setDefaultQuizRecords() {
    List<String> _quizRecordKeys = getRecordKeysForMode('quiz');
    for (String key in _quizRecordKeys) {
      _map[key] = 0;
    }
  }

  /// Writes quiz records to storage
  void _writeQuizRecordsToStorage() {
    List<String> _quizRecordKeys = getRecordKeysForMode('quiz');
    for (String key in _quizRecordKeys) {
      write(key, 0);
    }
  }

  /// Loads settings from storage.
  Future<void> _loadSettingsFromStorage(SharedPreferences pref) async {
    String? isOnDisk = pref.getString('difficulty');
    if (isOnDisk == null) {
      _setDefaultValues();
      await _writeDefaultsToStorage();
    } else {
      _map['volume'] = pref.get('volume');
      _map['difficulty'] = pref.get('difficulty');
      _map['theme'] = pref.get('theme');
    }
  }

  /// Sets the default settings in the map
  void _setDefaultSettings() {
    _map['volume'] = defaultVolumeLevel;
    _map['difficulty'] = defaultDifficultyLevel;
    _map['theme'] = defaultTheme;
  }

  /// Writes default settings to storage
  void _writeDefaultSettingsToStorage() async {
    write('volume', defaultVolumeLevel);
    write('difficulty', defaultDifficultyLevel);
    write('theme', defaultTheme);
  }

  Future<void> _resetLessons() async {
    final prefs = await SharedPreferences.getInstance();

    for (int x = 0; x < numOfLessons; x++) {
      prefs.setBool('lesson-num-$x', false);
    }
    //print("lessons reset");
  }

  Future<void> _resetQuizzes() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('completed_quizzes', 0);
    //print("quizzes reset");
  }

  Future<bool> displayLessonNotification() async {
    final prefs = await SharedPreferences.getInstance();

    int lessonsPassed = 0;

    for (int x = 0; x < numOfLessons; x++) {
      bool value = prefs.getBool('lesson-num-$x') ?? false;
      if (value) lessonsPassed += 1;
      //print('adding the $x one');
    }

    if (lessonsPassed == 1 ||
        lessonsPassed == 5 ||
        lessonsPassed == numOfLessons) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> displayQuizNotification() async {
    final prefs = await SharedPreferences.getInstance();
    int completedQuizzes = (prefs.getInt('completed_quizzes') ?? 0);

    if (completedQuizzes == 1 ||
        completedQuizzes == 5 ||
        completedQuizzes == numOfquizzes) {
      return true;
    } else {
      return false;
    }
  }

  //void _resetAchievements() {}
}
