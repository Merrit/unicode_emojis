# unicode_emojis 🎉

A Dart package that gives you all the Unicode emojis, skin tone variants, and
search. The data is generated from the awesome
[emoji-data](https://github.com/iamcal/emoji-data) repository, so it will always
be fresh and up to date. 🙌


## Features

- Contains over 3,000 emojis from Unicode 16.0. 😍
- Supports skin tone variations for human emojis and multi-person emojis. 🙋🏻‍♂️🙋🏼‍♀️🙋🏽‍♂️🙋🏾‍♀️🙋🏿‍♂️
- Provides an `Emoji` class that has all the info you need for each emoji. 🚀
- Access everything through the `UnicodeEmojis` class. 🎉
  - The `UnicodeEmojis.allEmojis` constant contains all the emojis. 📦
  - The `UnicodeEmojis.search` function finds the emojis that match your query. 🔎
    - Search by name, short name (e.g. `tada`), category (e.g. `flags`),
      subcategory (e.g. `country-flag`), or ASCII representation (e.g. `;)`).


## Usage

To use this package, add `unicode_emojis` as a dependency in your `pubspec.yaml` file.

Then import it in your Dart code:

```dart
import 'package:unicode_emojis/unicode_emojis.dart';
```

Here's a quick example:

```dart
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

```

For more details, please check out the [API reference](https://pub.dev/documentation/unicode_emojis/latest/).


## License

This package is licensed under the MIT license. See the [LICENSE](LICENSE) file for more information.
