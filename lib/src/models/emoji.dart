import 'dart:convert';

import 'package:collection/collection.dart';

import '../enums/category.dart';

/// Represents an emoji and its metadata.
class Emoji {
  const Emoji({
    required this.name,
    required this.emoji,
    required this.unified,
    required this.nonQualified,
    required this.shortName,
    required this.shortNames,
    required this.text,
    required this.texts,
    required this.category,
    required this.subcategory,
    required this.sortOrder,
    required this.addedIn,
    required this.hasImgApple,
    required this.hasImgGoogle,
    required this.hasImgTwitter,
    required this.hasImgFacebook,
    required this.skinVariations,
    required this.obsoletes,
    required this.obsoletedBy,
  });

  /// The offical Unicode name.
  final String name;

  /// The emoji itself, as a UTF-8 string.
  ///
  /// This is the version that should be used for display.
  /// Example: '🙇‍♀️'
  final String emoji;

  /// The Unicode codepoint, as 4-5 hex digits. Where an emoji needs 2 or more
  /// codepoints, they are specified like 1F1EA-1F1F8. For emoji that need to
  /// specifiy a variation selector (-FE0F), that is included here.
  final String unified;

  /// For emoji that also have usage without a variation selector, that version
  /// is included here (otherwise is null).
  final String? nonQualified;

  /// The commonly-agreed upon short name for the image, as supported in
  /// campfire, github etc via the :colon-syntax:
  final String shortName;

  /// An array of all the known short names.
  final List<String> shortNames;

  /// An ASCII version of the emoji (e.g. `:)`), or null where none exists.
  final String? text;

  /// An array of ASCII emoji that should convert into this emoji. Each ASCII
  /// emoji will only appear against a single emoji entry.
  final List<String>? texts;

  /// The category the emoji is in.
  final Category category;

  /// The subcategory the emoji is in.
  final String subcategory;

  /// Global sorting index for all emoji, based on Unicode CLDR ordering.
  final int sortOrder;

  /// Emoji version in which this codepoint/sequence was added (previously
  /// Unicode version).
  final String addedIn;

  /// Whether the emoji has an image on Apple platforms.
  final bool hasImgApple;

  /// Whether the emoji has an image on Google platforms.
  final bool hasImgGoogle;

  /// Whether the emoji has an image on Twitter platforms.
  final bool hasImgTwitter;

  /// Whether the emoji has an image on Facebook platforms.
  final bool hasImgFacebook;

  /// For emoji with multiple skin tone variations, a list of alternative
  /// glyphs, keyed by the skin tone. For emoji that support multiple skin tones
  /// within a single emoji, each skin tone is separated by a dash character.
  final List<Emoji>? skinVariations;

  /// Emoji that are no longer used, in preference of this emoji.
  final String? obsoletes;

  /// This emoji is no longer used, in preference of the [obsoletedBy] emoji.
  final String? obsoletedBy;

  @override
  String toString() => toJson();

  Emoji copyWith({
    String? name,
    String? emoji,
    String? unified,
    String? nonQualified,
    String? shortName,
    List<String>? shortNames,
    String? text,
    List<String>? texts,
    Category? category,
    String? subcategory,
    int? sortOrder,
    String? addedIn,
    bool? hasImgApple,
    bool? hasImgGoogle,
    bool? hasImgTwitter,
    bool? hasImgFacebook,
    List<Emoji>? skinVariations,
    String? obsoletes,
    String? obsoletedBy,
  }) {
    return Emoji(
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      unified: unified ?? this.unified,
      nonQualified: nonQualified ?? this.nonQualified,
      shortName: shortName ?? this.shortName,
      shortNames: shortNames ?? this.shortNames,
      text: text ?? this.text,
      texts: texts ?? this.texts,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      sortOrder: sortOrder ?? this.sortOrder,
      addedIn: addedIn ?? this.addedIn,
      hasImgApple: hasImgApple ?? this.hasImgApple,
      hasImgGoogle: hasImgGoogle ?? this.hasImgGoogle,
      hasImgTwitter: hasImgTwitter ?? this.hasImgTwitter,
      hasImgFacebook: hasImgFacebook ?? this.hasImgFacebook,
      skinVariations: skinVariations ?? this.skinVariations,
      obsoletes: obsoletes ?? this.obsoletes,
      obsoletedBy: obsoletedBy ?? this.obsoletedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'emoji': emoji,
      'unified': unified,
      'non_qualified': nonQualified,
      'short_name': shortName,
      'short_names': shortNames,
      'text': text,
      'texts': texts,
      'category': category,
      'subcategory': subcategory,
      'sort_order': sortOrder,
      'added_in': addedIn,
      'has_img_apple': hasImgApple,
      'has_img_google': hasImgGoogle,
      'has_img_twitter': hasImgTwitter,
      'has_img_facebook': hasImgFacebook,
      'skin_variations': skinVariations?.map((x) => x.toMap()).toList(),
      'obsoletes': obsoletes,
      'obsoleted_by': obsoletedBy,
    };
  }

  factory Emoji.fromMap(Map<String, dynamic> map) {
    final name = (map['name'] as String).toLowerCase();
    final unified = map['unified'] as String;
    final nonQualified = map['non_qualified'] as String?;
    final shortName = map['short_name'] as String;
    final shortNames = (map['short_names'] as List<dynamic>).cast<String>();
    final text = map['text'] as String?;
    final texts = (map['texts'] as List<dynamic>?)?.cast<String>();
    final category = Category.fromDescription(map['category'] as String) ??
        Category.smileysAndEmotion;
    final subcategory = map['subcategory'] as String;
    final sortOrder = map['sort_order'] as int;
    final addedIn = map['added_in'] as String;
    final hasImgApple = map['has_img_apple'] as bool;
    final hasImgGoogle = map['has_img_google'] as bool;
    final hasImgTwitter = map['has_img_twitter'] as bool;
    final hasImgFacebook = map['has_img_facebook'] as bool;

    final obsoletes = map['obsoletes'] as String?;
    final obsoletedBy = map['obsoleted_by'] as String?;

    final emoji = String.fromCharCodes(
      unified.split('-').map<int>((e) => int.parse(e, radix: 16)),
    );

    List<Emoji>? skinVariations;
    if (map['skin_variations'] != null) {
      skinVariations = <Emoji>[];
      final skinVariationMaps =
          (map['skin_variations'] as Map<String, dynamic>).values;
      for (final variation in skinVariationMaps) {
        skinVariations.add(
          Emoji(
            name: name,
            emoji: String.fromCharCodes(
              (variation['unified'] as String)
                  .split('-')
                  .map<int>((e) => int.parse(e, radix: 16)),
            ),
            unified: variation['unified'] as String,
            nonQualified: null,
            shortName: shortName,
            shortNames: shortNames,
            text: text,
            texts: texts,
            category: category,
            subcategory: subcategory,
            sortOrder: sortOrder,
            addedIn: variation['added_in'] as String,
            hasImgApple: variation['has_img_apple'] as bool,
            hasImgGoogle: variation['has_img_google'] as bool,
            hasImgTwitter: variation['has_img_twitter'] as bool,
            hasImgFacebook: variation['has_img_facebook'] as bool,
            skinVariations: null,
            obsoletes: obsoletes,
            obsoletedBy: obsoletedBy,
          ),
        );
      }
    }

    return Emoji(
      name: name,
      emoji: emoji,
      unified: unified,
      nonQualified: nonQualified,
      shortName: shortName,
      shortNames: shortNames,
      text: text,
      texts: texts,
      category: category,
      subcategory: subcategory,
      sortOrder: sortOrder,
      addedIn: addedIn,
      hasImgApple: hasImgApple,
      hasImgGoogle: hasImgGoogle,
      hasImgTwitter: hasImgTwitter,
      hasImgFacebook: hasImgFacebook,
      skinVariations: skinVariations,
      obsoletes: obsoletes,
      obsoletedBy: obsoletedBy,
    );
  }

  String toJson() => json.encode(toMap());

  factory Emoji.fromJson(String source) => Emoji.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Emoji &&
        other.name == name &&
        other.emoji == emoji &&
        other.unified == unified &&
        other.nonQualified == nonQualified &&
        other.shortName == shortName &&
        listEquals(other.shortNames, shortNames) &&
        other.text == text &&
        listEquals(other.texts, texts) &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.sortOrder == sortOrder &&
        other.addedIn == addedIn &&
        other.hasImgApple == hasImgApple &&
        other.hasImgGoogle == hasImgGoogle &&
        other.hasImgTwitter == hasImgTwitter &&
        other.hasImgFacebook == hasImgFacebook &&
        listEquals(other.skinVariations, skinVariations) &&
        other.obsoletes == obsoletes &&
        other.obsoletedBy == obsoletedBy;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        emoji.hashCode ^
        unified.hashCode ^
        nonQualified.hashCode ^
        shortName.hashCode ^
        shortNames.hashCode ^
        text.hashCode ^
        texts.hashCode ^
        category.hashCode ^
        subcategory.hashCode ^
        sortOrder.hashCode ^
        addedIn.hashCode ^
        hasImgApple.hashCode ^
        hasImgGoogle.hashCode ^
        hasImgTwitter.hashCode ^
        hasImgFacebook.hashCode ^
        skinVariations.hashCode ^
        obsoletes.hashCode ^
        obsoletedBy.hashCode;
  }
}
