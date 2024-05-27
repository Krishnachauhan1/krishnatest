class AlbumModel {
  int userId;
  int id;
  String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  // Method to convert JSON to AlbumModel
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }

  // Method to convert AlbumModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}
