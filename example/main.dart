import 'package:unicode_emojis/unicode_emojis.dart';

void main(List<String> args) {
  // You can access the list of all emojis using the `allEmojis` constant.
  const emojis = UnicodeEmojis.allEmojis;

  // Print the first 10 emojis.
  print(emojis.take(10).map((e) => e.emoji).toList());
  // => [😀, 😃, 😄, 😁, 😆, 😅, 🤣, 😂, 🙂, 🙃]

  // Search for emojis that contain the word "blue".
  final blueEmojis = UnicodeEmojis.search('blue');
  print(blueEmojis.map((e) => e.emoji).toList());
  // => [💙, 🩵, 🫐, 🚙, 📘, 🔵, 🟦, 🔷, 🔹]

  // Search by short name.
  final partyPopper = UnicodeEmojis.search('tada').first;
  print(partyPopper);
  // =>
  // {
  //   "name": "party popper",
  //   "emoji": "🎉",
  //   "unified": "1F389",
  //   "non_qualified": null,
  //   "short_name": "tada",
  //   "short_names": [
  //       "tada"
  //   ],
  //   "text": null,
  //   "texts": null,
  //   "category": "Activities",
  //   "subcategory": "event",
  //   "sort_order": 1045,
  //   "added_in": "0.6",
  //   "has_img_apple": true,
  //   "has_img_google": true,
  //   "has_img_twitter": true,
  //   "has_img_facebook": true,
  //   "skin_variations": null,
  //   "obsoletes": null,
  //   "obsoleted_by": null
  // }

  // Search by official Unicode name.
  final spoutingWhale = UnicodeEmojis.search('spouting whale').first;
  print(spoutingWhale.emoji);
  // => 🐳
  print(spoutingWhale.name);
  // => spouting whale

  // Get an emoji and its variations.
  final wavingEmoji = UnicodeEmojis.search('waving hand').first;
  print(wavingEmoji.emoji);
  // => 👋
  print(wavingEmoji.skinVariations!.map((e) => e.emoji).toList());
  // => [👋🏻, 👋🏼, 👋🏽, 👋🏾, 👋🏿]

  // Search for emoji by the ASCII representation.
  final winkEmoji = UnicodeEmojis.search(';)').first;
  print(winkEmoji.emoji);
  // => 😉
}
