// Copyright (c) 2018, the Dart Team. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in
// the LICENSE file.

// Try out some reflective invocations.
// Build with `cd ..; pub run build_runner build example`.

import 'package:reflectable/reflectable.dart';
import 'example.reflectable.dart';

@myReflectable
import 'package:flutter/material.dart';

class MyReflectable extends Reflectable {
  const MyReflectable()
      : super(typeCapability, libraryCapability, libraryDependenciesCapability);
}

const myReflectable = MyReflectable();

@myReflectable
class A {
  int arg0() => 42;
  int arg1(int x) => x - 42;
  int arg1to3(int x, int y, [int z = 0, w]) => x + y + z * 42;
  int argNamed(int x, int y, {int z = 42}) => x + y - z;
  int operator +(int x) => 42 + x;
  int operator [](int x) => 42 + x;
  void operator []=(x, v) {
    f = x + v;
  }

  int operator -() => -f;
  int operator ~() => f + 2;

  int f = 0;

  static int noArguments() => 42;
  static int oneArgument(x) => x - 42;
  static int optionalArguments(x, y, [z = 0, w]) => x + y + z * 42;
  static int namedArguments(int x, int y, {int z = 42}) => x + y - z;
}

void main() {
  // The program execution must start run this initialization before
  // any reflective features can be used.
  initializeReflectable();

  // Get hold of a few mirrors.
  var instance = A();
  var instanceMirror = myReflectable.reflect(instance);
  var classMirror = myReflectable.reflectType(A) as ClassMirror;
}
