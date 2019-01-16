import 'dart:html';

///
/// Sanitizer which does nothing.
///
class NullTreeSanitizer implements NodeTreeSanitizer {
  const NullTreeSanitizer();
  @override
  void sanitizeTree(Node node) {}
}

/// Usage
/// element.setInnerHtml(content, treeSanitizer: nullTreeSanitizer);
const nullTreeSanitizer = NullTreeSanitizer();

void setDisabled(Element element, bool disabled) {
  if (disabled == true) {
    element.attributes['disabled'] = '';
  } else {
    element.attributes.remove('disabled');
  }
}

void setEnabled(Element element, bool enabled) {
  setDisabled(element, !enabled);
}

void setHidden(Element element, bool hidden) {
  if (hidden == true) {
    element.attributes['hidden'] = '';
  } else {
    element.attributes.remove('hidden');
  }
}

bool isHidden(Element element) {
  return element.attributes.containsKey('hidden');
}

bool isDisabled(Element element) {
  return element.attributes.containsKey('disabled');
}

bool isEnabled(Element element) {
  return !isDisabled(element);
}

// Recursive into the parent to find the first parent matching the give id
/// [includeElement] if true also check the current element id
Element findFirstAncestorWithId(Element element, String id,
    [bool includeElement]) {
  Element parent;
  if (includeElement == true) {
    parent = element;
  } else {
    parent = element.parent;
  }
  while (parent != null && parent.id != id) {
    parent = parent.parent;
  }
  return parent;
}

// Recursive into the parent to find the first parent matching the class
/// [includeElement] if true also check the current element id
Element findFirstAncestorWithClass(Element element, String klass,
    [bool includeElement]) {
  Element parent;
  if (includeElement == true) {
    parent = element;
  } else {
    parent = element.parent;
  }
  while (parent != null && !parent.classes.contains(klass)) {
    parent = parent.parent;
  }
  return parent;
}
