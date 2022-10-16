import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:english_words/english_words.dart' as english_words;

String randomNoun() => english_words.nouns[Random().nextInt(english_words.nouns.length)];
String randomAdjective() =>
    english_words.adjectives[Random().nextInt(english_words.adjectives.length)];
String randomString() => "${randomAdjective()} ${randomNoun()}";

Map<String, dynamic> randomJson() => {
      "meta": "this is a random json for test purposes",
      randomString(): randomInt(),
      randomString(): randomBool(),
      randomString(): randomString(),
    };

DateTime randomTime() => DateTime.fromMicrosecondsSinceEpoch(
        (DateTime.now().millisecondsSinceEpoch / 1000000).floor() * 1000000)
    .toUtc(); // this gives accuracy to seconds
int randomInt() => Random().nextInt(100);
bool randomBool() => Random().nextDouble() > 0.5;

Exception randomException() => Exception(randomString());

Right forceRight<Left, Right>(Either<Left, Right> target) => target.fold(
      (left) => throw Exception("wanted target to be Right, but got Left value = $left"),
      (right) => right,
    );
