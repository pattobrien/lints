// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'example.dart' as prefix0;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.MyReflectable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'A',
            r'.A',
            134217735,
            0,
            const prefix0.MyReflectable(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {},
            0,
            -1,
            const <int>[-1],
            null,
            {})
      ],
      null,
      null,
      <Type>[prefix0.A],
      1,
      {},
      {},
      <m.LibraryMirror>[
        r.LibraryMirrorImpl(r'', Uri.parse(r'reflectable://0/'),
            const prefix0.MyReflectable(), const <int>[-1], {}, {}, null, {})
      ],
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
