import 'package:numeric/numeric.dart';

class BrontosaurusBody {
  final String username;
  final String namespace;
  final String mint;
  final List<String> groups;
  final List<String> tags;
  final Map<String, dynamic> infos;
  final Map<String, dynamic> beacons;
  final List<String> modifies;

  final String avatar;
  final String email;
  final String phone;
  final String displayName;
  final String organization;
  final List<String> organizationTags;

  BrontosaurusBody({
    this.username,
    this.namespace,
    this.mint,
    this.groups,
    this.tags,
    this.infos,
    this.beacons,
    this.modifies,
    this.avatar,
    this.email,
    this.phone,
    this.displayName,
    this.organization,
    this.organizationTags,
  });

  factory BrontosaurusBody.fromMap(Map<String, dynamic> map) {
    final List<dynamic> groups = map['groups'];
    final List<dynamic> tags = map['tags'];
    final List<dynamic> modifies = map['modifies'];

    List<String> parseOrganizationTags(dynamic organizationTags) {
      if (organizationTags is List) {
        final List<dynamic> list = organizationTags;
        return list.map((dynamic each) => each.toString()).toList();
      }
      return null;
    }

    return BrontosaurusBody(
      username: map['username'].toString(),
      namespace: map['namespace'].toString(),
      mint: map['mint'].toString(),
      groups: groups.map((dynamic group) => group.toString()).toList(),
      tags: tags.map((dynamic tag) => tag.toString()).toList(),
      infos: map['infos'],
      beacons: map['beacons'],
      modifies: modifies.map((dynamic modify) => modify.toString()).toList(),
      avatar: parseOptionalString(map['avatar']),
      email: parseOptionalString(map['email']),
      phone: parseOptionalString(map['phone']),
      displayName: parseOptionalString(map['displayName']),
      organization: parseOptionalString(map['organization']),
      organizationTags: parseOrganizationTags(map['organizationTags']),
    );
  }
}
