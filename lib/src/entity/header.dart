import 'package:numeric/numeric.dart';

class BrontosaurusHeader {
  final String algorithm;
  final String alg;

  final String attempt;
  final int expireAt;
  final int issuedAt;

  final String key;

  BrontosaurusHeader({
    this.algorithm,
    this.alg,
    this.attempt,
    this.expireAt,
    this.issuedAt,
    this.key,
  });

  factory BrontosaurusHeader.fromMap(Map<String, dynamic> map) {
    return BrontosaurusHeader(
      algorithm: map['algorithm'].toString(),
      alg: map['alg'].toString(),
      attempt: map['attempt'].toString(),
      expireAt: tryParseNullInt(map['expireAt']),
      issuedAt: tryParseNullInt(map['issuedAt']),
      key: map['key'].toString(),
    );
  }
}
