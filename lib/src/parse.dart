import 'package:brontosaurus_flutter/brontosaurus_flutter.dart';

class ParseCombinedResult {
  final String method;
  final String username;
  final String namespace;

  ParseCombinedResult(
    this.method,
    this.username,
    this.namespace,
  );
}

ParseCombinedResult parseUsernameNamespaceCombined(String combined) {
  final List<String> regularSplited = combined.split('/');
  if (regularSplited.length == 2) {
    return ParseCombinedResult(
      'regular',
      regularSplited[1],
      regularSplited[0],
    );
  }

  final List<String> urlFriendlySplited = combined.split('_');
  if (urlFriendlySplited.length == 2) {
    return ParseCombinedResult(
      'url-friendly',
      urlFriendlySplited[1],
      urlFriendlySplited[0],
    );
  }

  return ParseCombinedResult(
    'default',
    combined,
    DefaultBrontosaurusNamespace.DEFAULT,
  );
}
