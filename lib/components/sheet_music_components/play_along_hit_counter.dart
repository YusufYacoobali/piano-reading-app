import '../../storage_reader_writer.dart';

/// Keeps the score and highest score of the endless mode
class PlayAlongHitCounter {

  /// The current score
  int score = 0;

  /// The number of notes
  final int numNotes;

  /// The high score
  late double highScore;

  ///TODO: Make storage writer work for storing high score
  final StorageReaderWriter _writer = StorageReaderWriter();

  final String songName;

  late final String _difficulty;

  PlayAlongHitCounter({required this.songName, required this.numNotes});

  void setDifficulty(String difficulty) {
    _difficulty = difficulty;
    getHighScore();
  }

  /// Writes the high score to storage
  void writeHighScore() async {
    String key = '${songName.toLowerCase()}-${_difficulty.toLowerCase()}-high-score';
    String percentage = ((score/numNotes) * 100).toStringAsFixed(1);
    if (percentage[percentage.length-1] == '0') {
      percentage = double.parse(percentage).round().toString();
    }
    await _writer.write(key, percentage);
  }

  /// Gets the high score
  void getHighScore() {
    _writer.loadDataFromStorage().then((value) {
      String key = '${songName.toLowerCase()}-${_difficulty.toLowerCase()}-high-score';
      Object? percentage = _writer.read(key);
      if (percentage == null) {
        highScore = 0;
        writeHighScore();
      }
      else {
        highScore = double.parse(percentage.toString());
      }
    });
  }

  /// Updates the score if the new one is higher
  void isNewHighScore() {
    if (score/numNotes > highScore) {
      writeHighScore();
    }
  }
}