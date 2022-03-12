import 'package:sight_reading_app/lessons_and_quizzes/question_list.dart';
import 'package:sight_reading_app/question.dart';

/// List of questions for lesson 4.
///
/// Teaches how to read C D E F on Bass clef.

final QuestionList lessonFourQuestions =
    QuestionList(lessonID: 4, questionList: [
  ///Tutorial
  Question(
    image: 'Bs_C.jpeg',
    question:
        'Have you noticed that the symbol at the far left has changed? This is called the Base clef. The positions of the notes are different from when the notes are with the Treble clef. This is position of C on the Base clef which is under the middle line. Now press C in the option box.',
    correctAnswer: 'C',
  ),
  Question(
    image: 'Bs_D.jpeg',
    question:
        'This name is D (Re) on the Base clef. It is on the middle line of the staff. Now press D in the option box.',
    correctAnswer: 'D',
  ),
  Question(
    image: 'Bs_E.jpeg',
    question:
        'This is E (Mi) on the Base clef. It is between the second and third lines from top of the staff and is above D. Now press E in the option box.',
    correctAnswer: 'E',
  ),
  Question(
    image: 'Bs_F.jpeg',
    question:
        'This is F (Fa) on the Base clef. It is one the second from top line of the staff. Now press F in the option box.',
    correctAnswer: 'F',
  ),

  ///start questions
  Question(
    image: 'Bs_E.jpeg',
    question:
        'Great Job. Now you have learnt the first four notes on the Base clef. Try answering the rest of the questions without help. What note is this?',
    correctAnswer: 'E',
  ),
  Question(
    image: 'Bs_D.jpeg',
    question: 'What note is this?',
    correctAnswer: 'D',
  ),
  Question(
    image: 'Bs_F.jpeg',
    question: 'What note is this?',
    correctAnswer: 'F',
  ),
  Question(
    image: 'Bs_C.jpeg',
    question: 'What note is this?',
    correctAnswer: 'C',
  ),
  Question(
    image: 'Bs_D.jpeg',
    question: 'What note is this?',
    correctAnswer: 'D',
  ),
  Question(
    image: 'Bs_E.jpeg',
    question: 'What note is this?',
    correctAnswer: 'E',
  ),
  Question(
    image: 'Bs_C.jpeg',
    question: 'What note is this?',
    correctAnswer: 'C',
  ),
  Question(
    image: 'Bs_F.jpeg',
    question: 'What note is this?',
    correctAnswer: 'F',
  ),
  Question(
    image: 'Bs_C.jpeg',
    question: 'What note is this?',
    correctAnswer: 'C',
  ),
]);
