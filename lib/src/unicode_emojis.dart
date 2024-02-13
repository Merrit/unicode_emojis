import 'emoji_dataset.dart';
import 'models/emoji.dart';

/// A class that contains all emojis and provides a search function.
class UnicodeEmojis {
  /// The list of all emojis as a constant.
  static const List<Emoji> allEmojis = emojiDataset;

  /// A map that contains all emojis indexed by their properties.
  ///
  /// The keys are the properties of the emojis in lower case and the values are
  /// lists of emojis that have the property.
  ///
  /// Facilitates the search for emojis by their properties.
  static final Map<String, List<Emoji>> index = _createIndex();

  /// Creates the index of emojis by their properties.
  static Map<String, List<Emoji>> _createIndex() {
    final Map<String, List<Emoji>> index = {};

    for (final emoji in allEmojis) {
      final properties = [
        emoji.category.description,
        emoji.name,
        emoji.shortName,
        ...emoji.shortNames,
        emoji.subcategory,
        emoji.text,
        ...emoji.texts ?? [],
      ];

      for (final property in properties) {
        if (property == null) {
          continue;
        }

        final key = property.toLowerCase();

        if (index[key] == null) {
          index[key] = <Emoji>[];
        }

        index[key]!.add(emoji);
      }
    }

    return index;
  }

  /// Returns a list of emojis that match the given [query].
  ///
  /// The [limit] parameter can be used to limit the number of results.
  static List<Emoji> search(String query, {int? limit}) {
    final List<String> queryTerms = query
        .split(' ')
        .map((term) => term.toLowerCase())
        .where((term) => term.isNotEmpty)
        .toList();

    final matches = <String, int>{};

    for (final term in queryTerms) {
      for (final key in index.keys) {
        if (key.contains(term)) {
          matches[key] = (matches[key] ?? 0) + 1;
        }
      }
    }

    final sortedMatches = matches.keys.toList()
      ..sort((a, b) {
        final scoreComparison = matches[b]!.compareTo(matches[a]!);
        if (scoreComparison != 0) {
          return scoreComparison;
        }
        return a.compareTo(b);
      });

    final emojis = sortedMatches
        .map((match) => index[match]!)
        .expand((element) => element)
        .toSet()
        .toList();

    if (limit != null) {
      return emojis.take(limit).toList();
    } else {
      return emojis;
    }
  }
}
