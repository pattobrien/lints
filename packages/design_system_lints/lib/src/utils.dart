import 'package:analyzer/dart/element/element.dart';

bool hasDesignSystemAnnotation(Element? element) {
  if (element == null) return false;
  return element.thisOrAncestorMatching((p0) {
        final meta = p0.metadata;
        return meta.any((m) {
          final annotationUri = Uri(
              scheme: 'package',
              path: 'design_system_annotations/design_system_annotations.dart');
          final isEqual = m.element?.librarySource?.uri == annotationUri;
          return isEqual;
        });
      }) !=
      null;
}

bool hasMemberAnnotation(Element? element) {
  if (element == null) return false;
  return element.metadata.any((m) {
    if (m.element?.name != 'designSystemMember') return false;
    final annotationUri = Uri(
        scheme: 'package',
        path: 'design_system_annotations/design_system_annotations.dart');
    final isEqual = m.element?.librarySource?.uri == annotationUri;
    return isEqual;
  });
}
