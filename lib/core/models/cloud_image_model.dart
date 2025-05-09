import 'package:snibbo_app/core/entities/cloud_image_entity.dart';

class CloudImageModel {
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
  int pages;
  int bytes;
  String type;
  String etag;
  bool placeholder;
  String url;
  String secureUrl;
  String assetFolder;
  String displayName;
  String originalFilename;

  CloudImageModel({
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
    required this.pages,
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

  factory CloudImageModel.fromJson(Map<String, dynamic> json) =>
      CloudImageModel(
        assetId: json["asset_id"],
        publicId: json["public_id"],
        version: json["version"],
        versionId: json["version_id"],
        signature: json["signature"],
        width: json["width"],
        height: json["height"],
        format: json["format"],
        resourceType: json["resource_type"],
        createdAt: DateTime.parse(json["created_at"]),
        tags: List<dynamic>.from(json["tags"]),
        pages: json["pages"],
        bytes: json["bytes"],
        type: json["type"],
        etag: json["etag"],
        placeholder: json["placeholder"],
        url: json["url"],
        secureUrl: json["secure_url"],
        assetFolder: json["asset_folder"],
        displayName: json["display_name"],
        originalFilename: json["original_filename"],
      );

  CloudImageEntity toEntity() {
    return CloudImageEntity(
      assetId: assetId,
      publicId: publicId,
      version: version,
      versionId: versionId,
      signature: signature,
      width: width,
      height: height,
      format: format,
      resourceType: resourceType,
      createdAt: createdAt,
      tags: tags,
      pages: pages,
      bytes: bytes,
      type: type,
      etag: etag,
      placeholder: placeholder,
      url: url,
      secureUrl: secureUrl,
      assetFolder: assetFolder,
      displayName: displayName,
      originalFilename: originalFilename,
    );
  }
}
