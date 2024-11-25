class MediaModel {
  final int index;
  final String url;

  MediaModel({
    required this.index,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
        'index': index,
        'url': url,
      };

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        index: json['index'],
        url: json['url'],
      );
}
