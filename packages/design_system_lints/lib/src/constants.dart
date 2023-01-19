import 'package:sidecar/sidecar.dart';

/// Design system lints package Id.
const kPackageId = 'design_system_lints';

/// Url for design-system-lints github repo.
const kUrl =
    'https://github.com/pattobrien/lints/tree/main/packages/design_system_lints';

const boxShadow = TypeChecker.fromName('BoxShadow', packageName: 'flutter');
const textStyle = TypeChecker.fromName('TextStyle', packageName: 'flutter');
const container = TypeChecker.fromName('Container', packageName: 'flutter');
const sizedBox = TypeChecker.fromName('SizedBox', packageName: 'flutter');
const edgeInsets = TypeChecker.fromName('EdgeInsets', packageName: 'flutter');
const iconData = TypeChecker.fromName('IconData', packageName: 'flutter');
const borderRadius =
    TypeChecker.fromName('BorderRadius', packageName: 'flutter');
const color = TypeChecker.fromDartType('Color', package: 'ui');
