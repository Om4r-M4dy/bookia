import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> pushTo(BuildContext context, String location, {Object? extra}) {
  return context.push(location, extra: extra);
}

void replaceWith(BuildContext context, String location, {Object? extra}) {
  context.replace(location, extra: extra);
}

void removeUntil(BuildContext context, String location, {Object? extra}) {
  context.go(location, extra: extra);
}

void pop(BuildContext context) {
  context.pop();
}
