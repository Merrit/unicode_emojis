import 'package:test/test.dart';
import 'package:unicode_emojis/unicode_emojis.dart';

void main() {
  group('UnicodeEmojis:', () {
    group('search:', () {
      test('query "blue" returns expected emojis', () {
        final emojis = UnicodeEmojis.search('blue');
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['📘', '💙', '🚙', '🫐', '🔵', '🔷', '🟦', '🩵', '🔹'],
        );
      });

      test('query with leading spaces', () {
        final emojis = UnicodeEmojis.search('  blue');
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['📘', '💙', '🚙', '🫐', '🔵', '🔷', '🟦', '🩵', '🔹'],
        );
      });

      test('query with trailing spaces', () {
        final emojis = UnicodeEmojis.search('blue  ');
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['📘', '💙', '🚙', '🫐', '🔵', '🔷', '🟦', '🩵', '🔹'],
        );
      });

      test('query with leading and trailing spaces', () {
        final emojis = UnicodeEmojis.search(' blue ');
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['📘', '💙', '🚙', '🫐', '🔵', '🔷', '🟦', '🩵', '🔹'],
        );
      });

      test('query with multiple spaces', () {
        final emojis = UnicodeEmojis.search('  blue  ');
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['📘', '💙', '🚙', '🫐', '🔵', '🔷', '🟦', '🩵', '🔹'],
        );
      });

      test('query with multiple words', () {
        final emojis = UnicodeEmojis.search('blue heart', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['💙', '🩵', '🫀', '💓', '🖤', '♥️', '📘', '🚙', '🫐', '💔'],
        );
      });

      test('query with multiple words with leading and trailing spaces', () {
        final emojis = UnicodeEmojis.search(' blue heart ', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['💙', '🩵', '🫀', '💓', '🖤', '♥️', '📘', '🚙', '🫐', '💔'],
        );
      });

      test('query with multiple words with multiple spaces', () {
        final emojis = UnicodeEmojis.search('blue    heart', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['💙', '🩵', '🫀', '💓', '🖤', '♥️', '📘', '🚙', '🫐', '💔'],
        );
      });

      test('query "index pointing" returns expected emojis', () {
        final emojis = UnicodeEmojis.search('index pointing', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['🫵', '👇', '👈', '👉', '👆', '☝️', '⤵️', '⤴️', '⏬', '⏪'],
        );
      });

      test('query with reversed words', () {
        final emojis = UnicodeEmojis.search('pointing index', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['🫵', '👇', '👈', '👉', '👆', '☝️', '⤵️', '⤴️', '⏬', '⏪'],
        );
      });

      test('query with capitalized words', () {
        final emojis = UnicodeEmojis.search('Index Pointing', limit: 10);
        expect(
          emojis.map((emoji) => emoji.emoji),
          ['🫵', '👇', '👈', '👉', '👆', '☝️', '⤵️', '⤴️', '⏬', '⏪'],
        );
      });
    });
  });
}
