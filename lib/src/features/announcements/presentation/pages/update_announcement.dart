class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String classification;
  final List<String> imageUrls; // existing Firebase URLs

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.classification,
    required this.imageUrls,
  });
}
