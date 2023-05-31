import 'emoji_dataset.dart';
import 'models/emoji.dart';

/// A class that contains all emojis and provides a search function.
class UnicodeEmojis {
  /// The list of all emojis as a constant.
  static const List<Emoji> allEmojis = emojiDataset;

  /// Returns a list of emojis that match the given [query].
  static List<Emoji> search(String query) {
    final List<String> queryTerms = query
        .split(' ')
        .map((term) => term.toLowerCase())
        .toList()
      ..removeWhere((term) => term.isEmpty);

    return allEmojis
        .where((emoji) => queryTerms.every((term) =>
            emoji.category.description.toLowerCase().contains(term) ||
            emoji.name.toLowerCase().contains(term) ||
            emoji.shortName.toLowerCase().contains(term) ||
            emoji.shortNames
                .map((shortName) => shortName.toLowerCase())
                .contains(term) ||
            emoji.subcategory.toLowerCase().contains(term) ||
            emoji.text?.toLowerCase().contains(term) == true ||
            emoji.texts?.map((text) => text.toLowerCase()).contains(term) ==
                true))
        .toList();
  }
}
