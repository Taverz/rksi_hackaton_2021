class NamePage {
  final String name;
  const NamePage({required this.name});

  factory NamePage.fromMap(Map map) {
    return NamePage(
      name: map["name"] ?? "",
    );
  }
}
