import 'package:sight_reading_app/lessons_and_quizzes/question_list.dart';
import 'package:sight_reading_app/question.dart';

import '../components/sheet_music_components/note.dart';

//List of questions
//Teaches how to read Do Re Mi

final QuestionList lessonOneQuestions =
    QuestionList(lessonID: 1, questionList: [
  //Tutorial
  Question(
    note: Note(name: 'C4', duration: 4),
    clef: Clef.treble,
    question:
        'We are going to learn how to read notes. All music notes will be on the lines or spaces of the musical staff. The far left symbol is called the Treble clef. This is our first note. The name is C (Do). It is a circle with a short line across it. Now press C in the option box.',
    correctAnswer: 'C',
  ),
  Question(
    note: Note(name: 'D4', duration: 4),
    clef: Clef.treble,
    question:
        'This is our second note. The name is D (Re). It is directly under the lowest line. Now press D in the option box.',
    correctAnswer: 'D',
  ),
  Question(
    note: Note(name: 'E4', duration: 4),
    clef: Clef.treble,
    question:
        'This is our third note. The name is E (Mi). The circle is across the lowest line of the 5 line staff. Now press E in the option box.',
    correctAnswer: 'E',
  ),
  //start questions
  Question(
    note: Note(name: 'C4', duration: 4),
    clef: Clef.treble,
    question:
        'Great Job. Now you have learnt the first three notes. Try answering the rest of the questions without help. What note is this?',
    correctAnswer: 'C',
  ),
  Question(
    note: Note(name: 'D4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'D',
  ),
  Question(
    note: Note(name: 'E4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'E',
  ),
  Question(
    note: Note(name: 'D4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'D',
  ),
  Question(
    note: Note(name: 'E4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'E',
  ),
  Question(
    note: Note(name: 'C4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'C',
  ),
  Question(
    note: Note(name: 'D4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'E',
  ),
  Question(
    note: Note(name: 'C4', duration: 4),
    clef: Clef.treble,
    question: 'What note is this?',
    correctAnswer: 'C',
  ),
]);
