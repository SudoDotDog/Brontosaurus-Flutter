import 'dart:convert';

import 'package:brontosaurus_flutter/src/declare.dart';

class Token {
  static Token create(String raw) {
    return Token(raw);
  }

  String _raw;
  Map<String, dynamic> _header;
  Map<String, dynamic> _body;
  String _signiture;

  Token(String raw) {
    _raw = raw;
    final List<String> splited = raw.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final header = _decodeBase64(splited[0]);
    final body = _decodeBase64(splited[1]);
    _signiture = splited[2];
    _header = jsonDecode(header);
    _body = jsonDecode(body);
  }

  String get raw {
    return _raw;
  }

  List<String> get groups {
    final List<dynamic> before = _body["groups"];
    return before.map((dynamic each) => each.toString()).toList();
  }

  String get mint {
    return _body["mint"];
  }

  Map<String, dynamic> get infos {
    return _body["infos"];
  }

  Map<String, dynamic> get beacons {
    return _body["beacons"];
  }

  List<String> get modifies {
    final List<dynamic> before = _body["modifies"];
    return before.map((dynamic each) => each.toString()).toList();
  }

  String get username {
    return _body["username"];
  }

  String get namespace {
    return _body["namespace"];
  }

  String get displayName {
    return _body["displayName"];
  }

  String get avatar {
    return _body["avatar"];
  }

  String get email {
    return _body["email"];
  }

  String get phone {
    return _body["phone"];
  }

  String get name {
    if (_body["displayName"]) {
      return _body["displayName"];
    }
    return this.username;
  }

  Map<String, dynamic> get header {
    return _header;
  }

  String get signature {
    return _signiture;
  }

  String get organization {
    return _body["organization"];
  }

  List<String> get tags {
    if (_body["tags"] != null) {
      final List<dynamic> before = _body["tags"];
      return before.map((dynamic each) => each.toString()).toList();
    }
    return <String>[];
  }

  List<String> get organizationTags {
    if (_body["organizationTags"] != null) {
      final List<dynamic> before = _body["organizationTags"];
      return before.map((dynamic each) => each.toString()).toList();
    }
    return <String>[];
  }

  List<String> get combineTags {
    return this.tags + this.organizationTags;
  }

  int get expireAt {
    return _header["expireAt"];
  }

  int get issuedAt {
    return _header["issuedAt"];
  }

  String get applicationKey {
    return _header["key"];
  }

  bool hasGroup(String group) {
    final List<String> groups = this.groups;
    for (final String each in groups) {
      if (each == group) {
        return true;
      }
    }
    return false;
  }

  String getCombined() {
    return this._joinCombined('/');
  }

  String getURLFriendlyCombined() {
    return this._joinCombined('_');
  }

  bool sameApplication(String key) {
    return this.applicationKey == key;
  }

  bool validate() {
    return DateTime.now().millisecondsSinceEpoch < this.expireAt;
  }

  String _decodeBase64(String input) {
    final Base64Decoder base64Decoder = Base64Decoder();

    final int difference = input.length % 4;
    if (difference != 0) {
      return String.fromCharCodes(
          base64Decoder.convert(input + "=" * (4 - difference)));
    }
    return String.fromCharCodes(base64Decoder.convert(input));
  }

  String _joinCombined(String separator) {
    if (this.namespace == null) {
      return this.username;
    }
    if (this.namespace == DefaultBrontosaurusNamespace.DEFAULT) {
      return this.username;
    }

    return "${this.namespace}$separator${this.username}";
  }
}
