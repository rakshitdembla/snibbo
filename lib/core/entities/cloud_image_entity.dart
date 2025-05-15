class CloudImageEntity {
  String assetId;
  String publicId;
  int version;
  String versionId;
  String signature;
  int width;
  int height;
  String format;
  String resourceType;
  DateTime createdAt;
  List<dynamic> tags;
  int bytes;
  String type;
  String etag;
  bool placeholder;
  String url;
  String secureUrl;
  String assetFolder;
  String displayName;
  String originalFilename;

  CloudImageEntity({
    required this.assetId,
    required this.publicId,
    required this.version,
    required this.versionId,
    required this.signature,
    required this.width,
    required this.height,
    required this.format,
    required this.resourceType,
    required this.createdAt,
    required this.tags,
    required this.bytes,
    required this.type,
    required this.etag,
    required this.placeholder,
    required this.url,
    required this.secureUrl,
    required this.assetFolder,
    required this.displayName,
    required this.originalFilename,
  });
}
