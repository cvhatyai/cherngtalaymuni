class ListBannerImg {
  final String id;
  final String subject;
  final String description;
  final String url;
  final String create_date;
  final String display_image;

  ListBannerImg(
      {this.id,
      this.subject,
      this.description,
      this.url,
      this.create_date,
      this.display_image});

  factory ListBannerImg.fromJson(Map<String, dynamic> json) {
    return ListBannerImg(
        id: json['id'] as String,
        subject: json['subject'] as String,
        description: json['description'] as String,
        url: json['url'] as String,
        create_date: json['create_date'] as String,
        display_image: json['display_image'] as String);
  }
}
