class InfoPages {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoPages({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory InfoPages.fromJson(Map<String, dynamic> json) => InfoPages(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}
