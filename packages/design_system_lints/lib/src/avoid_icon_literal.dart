import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';
import 'generic_rule.dart';

/// Avoid using hardcoded Icons.
class AvoidIconLiteral extends GenericDesignRule {
  static const _id = 'avoid_icon_literal';
  static const _message = 'Avoid using Icons or IconData literals';
  static const _correction = 'Use values in design system spec instead';

  @override
  LintCode get code => const LintCode(_id, package: kPackageId, url: kUrl);

  @override
  bool Function(DartType? type) get checker => iconData.isAssignableFromType;

  @override
  String get correction => _correction;

  @override
  String get message => _message;
}
