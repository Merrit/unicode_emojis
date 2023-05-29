/// Enum of emoji categories.
enum Category {
  smileysAndEmotion('Smileys & Emotion'),
  peopleAndBody('People & Body'),
  animalsAndNature('Animals & Nature'),
  foodAndDrink('Food & Drink'),
  travelAndPlaces('Travel & Places'),
  activities('Activities'),
  objects('Objects'),
  symbols('Symbols'),
  flags('Flags');

  /// The human-readable description of the category.
  final String description;

  const Category(this.description);

  /// Returns the [Category] enum value from the given [description].
  ///
  /// Returns `null` if no match is found.
  static Category? fromDescription(String description) {
    for (final category in Category.values) {
      if (category.description == description) {
        return category;
      }
    }
    return null;
  }

  String toJson() => description;
}
