import 'package:sight_reading_app/components/achievement_components/achievement_card.dart';
//import 'package:sight_reading_app/storage_reader_writer.dart';

import '../../constants.dart';

/// This file reads the values from storage and makes the achievement cards which is used for both tabs

class AchievementMaker {
  //StorageReaderWriter storage = StorageReaderWriter();

  List<AchievementCard> achieved = [];
  List<AchievementCard> inProgress = [];

  void makeLists(allValues) {
    //print(achieveValues);
    List<AchievementCard> achieveObjects = makeAchievements(allValues);
    //print(achieveObjects);

    //deciding where each card will go
    if (achieveObjects.isNotEmpty) {
      for (AchievementCard card in achieveObjects) {
        if (card.complete >= card.target) {
          achieved.add(card);
        } else {
          inProgress.add(card);
        }
      }
    }
  }

  List<AchievementCard> getAchieved() {
    return achieved;
  }

  List<AchievementCard> getInProgress() {
    return inProgress;
  }

  List<AchievementCard> makeAchievements(achieveValues) {
    //print('these are values recieved $achieveValues');

    //2nd value passed in is how many have been completed
    List<AchievementCard> achievements = [
      AchievementCard(
          'Complete 1 lesson', 1, achieveValues['completedLessons']),
      AchievementCard(
          'Complete 5 lessons', 5, achieveValues['completedLessons']),
      AchievementCard('Complete all lessons', numOfLessons,
          achieveValues['completedLessons']),

      AchievementCard(
          'Complete your 1st quiz', 1, achieveValues['completedQuizzes']),
      AchievementCard(
          'Complete 5 quizzes', 5, achieveValues['completedQuizzes']),
      AchievementCard('Complete all quizzes', numOfquizzes,
          achieveValues['completedQuizzes']),

      AchievementCard(
          'score 5 or higher on endless (treble in beginner difficulty)',
          5,
          achieveValues['endlessTrebleBegHS']),
      AchievementCard(
          'score 10 or higher on endless (treble in beginner difficulty)',
          10,
          achieveValues['endlessTrebleBegHS']),
      AchievementCard(
          'score 10 or higher on endless (treble in intermediate difficulty)',
          10,
          achieveValues['endlessTrebleInterHS']),
      AchievementCard(
          'score 15 or higher on endless (treble in intermediate difficulty)',
          15,
          achieveValues['endlessTrebleInterHS']),
      AchievementCard(
          'score 20 or higher on endless (treble in expert difficulty)',
          20,
          achieveValues['endlessTrebleExpHS']),

      AchievementCard(
          'score 5 or higher on endless (bass in beginner difficulty)',
          5,
          achieveValues['endlessBassBegHS']),
      AchievementCard(
          'score 10 or higher on endless (bass in beginner difficulty)',
          10,
          achieveValues['endlessBassBegHS']),

      AchievementCard(
          'score 10 or higher on endless (bass in intermediate difficulty)',
          10,
          achieveValues['endlessBassInterHS']),
      AchievementCard(
          'score 15 or higher on endless (bass in intermediate difficulty)',
          15,
          achieveValues['endlessBassInterHS']),

      AchievementCard(
          'score 20 or higher on endless (bass in expert difficulty)',
          20,
          achieveValues['endlessBassExpHS']),

      //AchievementCard('Complete Ode to Joy play along', 100, complete),
      //AchievementCard('Complete the simple bass melody play along', 100, complete),
      //AchievementCard('Pass the 10 second speed run', 10, complete),
      //AchievementCard('Pass the 20 second speed run', 10, complete),
      //AchievementCard('Pass the 30 second speed run', 10, complete),
      //AchievementCard('Pass the 40 second speed run', 10, complete),
      //AchievementCard('Pass the 50 second speed run', 10, complete),
      //AchievementCard('Pass the 60 second speed run', 10, complete),
    ];
    //print(achievements);
    return achievements;
  }
}
