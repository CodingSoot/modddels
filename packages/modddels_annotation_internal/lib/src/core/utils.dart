import 'dart:math';

import 'package:characters/characters.dart';

/// Shortens the [text] using an ellipsis if its number of characters exceeds
/// [maxLength].
///
/// If [showEllipsisCount] is true, then it shows the number of characters that
/// were "ellipsized away" between parenthesis.
///
/// Example :
///
/// ```dart
/// final text = 'This is a new text';
///
/// final ellipsized1 = _ellipsize(
///   text,
///   maxLength: 14,
///   showEllipsisCount: false,
/// );
/// /// => 'This is a new…'
///
/// final ellipsized2 = _ellipsize(
///   text,
///   maxLength: 14,
///   showEllipsisCount: true,
/// );
/// /// => 'This is … (+4)'
///
/// /// Notice how both strings are exactly 14 characters long.
/// ```
///
/// NB : For a  specific definition of what is considered a character, see the
/// [characters](https://pub.dev/packages/characters) package on Pub.
///
String ellipsize(
  String text, {
  required int maxLength,
  bool showEllipsisCount = true,
}) {
  assert(maxLength > 0);

  final characters = Characters(text);

  if (characters.length <= maxLength) {
    return characters.string;
  }

  if (!showEllipsisCount) {
    // The final string result should not exceed maxLength, so we take into
    // take into account the added '…' character
    final end = maxLength - 1;
    return '${characters.getRange(0, end).string}…';
  }

  final shownTextLength =
      _calculateShownTextLength(characters.length, maxLength);

  // The number of characters hidden by the ellipsis.
  final ellipsisCount = characters.length - shownTextLength;

  return '${characters.getRange(0, shownTextLength).string}… (+$ellipsisCount)';
}

/// Returns the number of characters from the initial text that will be shown
/// after an ellipsization with `showEllipsisCount` set to true.
///
/// For example : Given a text that is 14 characters long that we want to
/// ellipsize to only be 9 characters long. The portion of the text that will be
/// shown will only be 2 characters long, while the remaining 6 characters will
/// be taken by the ellipsis count "… (+12)"
///
int _calculateShownTextLength(int initialTextLength, int maxLength) {
  assert(initialTextLength > maxLength);

  // The first approximation of the ellipsis count (which is the number of
  // characters from the initial text that will be hidden by the ellipsis.)
  final initialEllipsisCount = initialTextLength - maxLength;

  var previousEllipsisCount = initialEllipsisCount;

  // We first calculate the [shownTextLength] according to our approximation of
  // the ellipsis count. Then, we calculate the new ellipsis count.
  // - If the new ellipsis count has the same length as the previous one, it
  //   means that the [shownTextLength] will remain the same, and thus is
  //   accurate.
  // - If the new ellipsis count has a different length than the previous one ,
  //   it means that the [shownTextLength] will have to change, so we redo the
  //   calculations with the new values.
  while (true) {
    // This includes the extra characters : `… (+)` and the length of the
    // "ellipsis count"
    final extraCharactersCount = 5 + previousEllipsisCount.toString().length;

    final shownTextLength = max(maxLength - extraCharactersCount, 0);

    final newEllipsisCount = initialTextLength - shownTextLength;

    if (newEllipsisCount.toString().length ==
        previousEllipsisCount.toString().length) {
      return shownTextLength;
    }

    previousEllipsisCount = newEllipsisCount;
  }
}
