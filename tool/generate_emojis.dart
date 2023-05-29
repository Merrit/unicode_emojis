import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unicode_emojis/src/models/emoji.dart';

/// Run this to generate the Dart file containing the list of emojis.
///
/// The file contains a const list of [Emoji] objects as the dataset.
/// This is only needed if you want to update the list of emojis.
///
/// Generated file: lib/src/emoji_dataset.dart
Future<void> main() async {
  final String emojisJsonString = await _downloadEmojiJson();
  final List<Emoji> emojis = await _jsonToEmojiList(emojisJsonString);
  final List<Emoji> sortedEmojis = _sortEmojis(emojis);
  final String emojisFileString = await _emojisToString(sortedEmojis);
  await _writeEmojisFile(emojisFileString);
}

/// Downloads the emoji.json file from `iamcal/emoji-data` and returns the data
/// as a string.
Future<String> _downloadEmojiJson() async {
  final response = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji.json',
    ),
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load emoji.json');
  }
}

/// Converts the emoji json to a list of [Emoji] objects and returns the list.
Future<List<Emoji>> _jsonToEmojiList(String emojisJsonString) async {
  final List emojisJson = jsonDecode(emojisJsonString) as List<dynamic>;

  final List<Emoji> emojis = [];
  for (final emojiMap in emojisJson) {
    final emoji = Emoji.fromMap(emojiMap as Map<String, dynamic>);
    emojis.add(emoji);
  }

  return emojis;
}

/// Sorts the list of [Emoji] objects by the Unicode CLDR ordering.
List<Emoji> _sortEmojis(List<Emoji> emojis) {
  emojis.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  return emojis;
}

/// Converts the list of [Emoji] objects to a string for writing to a file.
Future<String> _emojisToString(List<Emoji> emojis) async {
  // Get the highest unicode version.
  double unicodeVersion = 1.0;
  for (final emoji in emojis) {
    final emojiUnicodeVersion = double.parse(emoji.addedIn);
    if (emojiUnicodeVersion > unicodeVersion) {
      unicodeVersion = emojiUnicodeVersion;
    }
  }

  final buffer = StringBuffer();

  buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  buffer.writeln('// ignore_for_file: public_member_api_docs');
  buffer.writeln('');
  buffer.writeln(r"import 'enums/category.dart';");
  buffer.writeln(r"import 'models/emoji.dart';");
  buffer.writeln('');
  buffer.writeln('/// The Unicode version of this emoji list.');
  buffer.writeln('const double unicodeVersion = $unicodeVersion;');
  buffer.writeln('');
  buffer.writeln('/// List of all emojis.');
  buffer.writeln('const List<Emoji> emojiDataset = [');

  for (final emoji in emojis) {
    buffer.writeln('  ${_emojiToString(emoji)},');
  }

  buffer.writeln('];');

  return buffer.toString();
}

/// Converts a single [Emoji] object to a string representation.
String _emojiToString(Emoji emoji) {
  final buffer = StringBuffer();
  buffer.writeln('Emoji(');
  buffer.writeln("  name: '${emoji.name}',");
  buffer.writeln("  emoji: '${emoji.emoji}',");
  buffer.writeln("  unified: '${emoji.unified}',");

  if (emoji.nonQualified != null) {
    buffer.writeln("  nonQualified: '${emoji.nonQualified}',");
  } else {
    buffer.writeln('  nonQualified: null,');
  }

  buffer.writeln("  shortName: '${emoji.shortName}',");

  buffer.writeln('  shortNames: [');
  for (final shortName in emoji.shortNames) {
    buffer.writeln("    '$shortName',");
  }
  buffer.writeln('  ],');

  if (emoji.text != null) {
    buffer.writeln('  text: r"${emoji.text}",');
  } else {
    buffer.writeln('  text: null,');
  }

  if (emoji.texts != null) {
    buffer.writeln('  texts: [');
    for (final text in emoji.texts!) {
      buffer.writeln('    r"$text",');
    }
    buffer.writeln('  ],');
  } else {
    buffer.writeln('  texts: null,');
  }

  buffer.writeln('  category: ${emoji.category},');
  buffer.writeln("  subcategory: '${emoji.subcategory}',");
  buffer.writeln('  sortOrder: ${emoji.sortOrder},');
  buffer.writeln("  addedIn: '${emoji.addedIn}',");
  buffer.writeln('  hasImgApple: ${emoji.hasImgApple},');
  buffer.writeln('  hasImgGoogle: ${emoji.hasImgGoogle},');
  buffer.writeln('  hasImgTwitter: ${emoji.hasImgTwitter},');
  buffer.writeln('  hasImgFacebook: ${emoji.hasImgFacebook},');

  if (emoji.skinVariations != null) {
    buffer.writeln('  skinVariations: [');
    for (final skinVariation in emoji.skinVariations!) {
      buffer.writeln('    ${_emojiToString(skinVariation)},');
    }
    buffer.writeln('  ],');
  } else {
    buffer.writeln('  skinVariations: null,');
  }

  if (emoji.obsoletes != null) {
    buffer.writeln("  obsoletes: '${emoji.obsoletes}',");
  } else {
    buffer.writeln('  obsoletes: null,');
  }

  if (emoji.obsoletedBy != null) {
    buffer.writeln("  obsoletedBy: '${emoji.obsoletedBy}',");
  } else {
    buffer.writeln('  obsoletedBy: null,');
  }

  buffer.writeln(')');

  return buffer.toString();
}

/// Writes the emojis file to lib/src/emoji_dataset.dart.
Future<void> _writeEmojisFile(String emojisFileString) async {
  final file = File('lib/src/emoji_dataset.dart');
  await file.writeAsString(emojisFileString.toString());
}
