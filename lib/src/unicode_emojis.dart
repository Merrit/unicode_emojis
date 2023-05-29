import 'emoji_dataset.dart';
import 'models/emoji.dart';

/// A class that contains all emojis and provides a search function.
class UnicodeEmojis {
  /// The list of all emojis as a constant.
  static const List<Emoji> allEmojis = emojiDataset;

  /// Returns a list of emojis that match the given [query].
  static List<Emoji> search(String query) {
    final String lowerQuery = query.toLowerCase();

    return allEmojis
        .where((emoji) =>
            emoji.category.description.toLowerCase().contains(lowerQuery) ||
            emoji.name.toLowerCase().contains(lowerQuery) ||
            emoji.shortName.toLowerCase().contains(lowerQuery) ||
            emoji.shortNames
                .map((shortName) => shortName.toLowerCase())
                .contains(lowerQuery) ||
            emoji.subcategory.toLowerCase().contains(lowerQuery) ||
            emoji.text?.toLowerCase().contains(lowerQuery) == true ||
            emoji.texts
                    ?.map((text) => text.toLowerCase())
                    .contains(lowerQuery) ==
                true)
        .toList();
  }
}
