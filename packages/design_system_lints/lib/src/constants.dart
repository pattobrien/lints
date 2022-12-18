import 'package:sidecar/sidecar.dart';

/// Design system lints package Id.
const kPackageId = 'design_system_lints';

/// Url for design-system-lints github repo.
const kUrl =
    'https://github.com/pattobrien/lints/tree/main/packages/design_system_lints';

final boxShadow = TypeChecker.fromName('BoxShadow', packageName: 'flutter');
final textStyle = TypeChecker.fromName('TextStyle', packageName: 'flutter');
final container = TypeChecker.fromName('Container', packageName: 'flutter');
final sizedBox = TypeChecker.fromName('SizedBox', packageName: 'flutter');
final edgeInsets = TypeChecker.fromName('EdgeInsets', packageName: 'flutter');
final iconData = TypeChecker.fromName('IconData', packageName: 'flutter');
final borderRadius =
    TypeChecker.fromName('BorderRadius', packageName: 'flutter');
final color = TypeChecker.fromDartType('Color', package: 'ui');
