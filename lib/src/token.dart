import 'dart:convert';

import 'package:brontosaurus_flutter/src/declare.dart';
import 'package:brontosaurus_flutter/src/entity/body.dart';
import 'package:brontosaurus_flutter/src/entity/header.dart';
import 'package:brontosaurus_flutter/src/util.dart';

class Token {
  final String raw;
  final BrontosaurusHeader header;
  final BrontosaurusBody body;
  final String signature;

  Token({
    this.raw,
    this.header,
    this.body,
    this.signature,
  });

  factory Token.create(String raw) {
    final List<String> splited = raw.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final String rawHeader = decodeBase64(splited[0]);
    final String rawBody = decodeBase64(splited[1]);
    final String signature = splited[2].toString();

    final BrontosaurusHeader header =
        BrontosaurusHeader.fromMap(jsonDecode(rawHeader));
    final BrontosaurusBody body = BrontosaurusBody.fromMap(jsonDecode(rawBody));

    return Token(
      raw: raw,
      header: header,
      body: body,
      signature: signature,
    );
  }

  List<String> get groups {
    return this.body.groups;
  }

  String get mint {
    return this.body.mint;
  }

  Map<String, dynamic> get infos {
    return this.body.infos;
  }

  Map<String, dynamic> get beacons {
    return this.body.beacons;
  }

  List<String> get modifies {
    return this.body.modifies;
  }

  String get username {
    return this.body.username;
  }

  String get namespace {
    return this.body.namespace;
  }

  String get displayName {
    return this.body.displayName;
  }

  String get avatar {
    return this.body.avatar;
  }

  String get email {
    return this.body.email;
  }

  String get phone {
    return this.body.phone;
  }

  String get name {
    if (this.body.displayName is String) {
      return this.body.displayName;
    }
    return this.username;
  }

  String get organization {
    return this.body.organization;
  }

  List<String> get tags {
    return this.body.tags;
  }

  List<String> get organizationTags {
    if (this.body.organizationTags == null) {
      return [];
    }
    return this.body.organizationTags;
  }

  List<String> get combineTags {
    return this.tags + this.organizationTags;
  }

  int get expireAt {
    return this.header.expireAt;
  }

  int get issuedAt {
    return this.header.issuedAt;
  }

  String get applicationKey {
    return this.header.key;
  }

  bool hasGroup(String group) {
    for (final String each in this.groups) {
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
