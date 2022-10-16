import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../logic/entity/network_use_case_factory.dart';
import 'fixture_reader.dart';

void baseOutMapperTest<Entity>({
  required Entity entity,
  required OutMapper<Entity> mapper,
  required String fixtureName,
}) {
  test("should convert a fixture to an entity", () async {
    // arrange
    final tJson = json.decode(fixture(fixtureName));
    // act
    final result = mapper.fromJson(tJson);
    // assert
    expect(result, entity);
  });
}

void baseInpMapperTest<Entity>({
  required Entity entity,
  required InpMapper<Entity> mapper,
  required String fixtureName,
}) {
  test("should convert an entity to valid json", () async {
    // act
    final result = mapper.toJson(entity);
    // assert
    final wantJson = json.decode(fixture(fixtureName));
    expect(result, wantJson);
  });
}

void baseFullMapperTest<Entity>({
  required Entity entity,
  required FullMapper<Entity> mapper,
  required String fixtureName,
}) {
  baseInpMapperTest(entity: entity, mapper: mapper, fixtureName: fixtureName);
  baseOutMapperTest(entity: entity, mapper: mapper, fixtureName: fixtureName);
}
