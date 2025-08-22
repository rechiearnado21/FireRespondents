class Category {
  final String? title;
  final String? image;

  const Category({this.title, this.image});

  // Static list so we can call directly: Category.menuCategory
  static const List<Category> menuCategory = [
    Category(title: "Police", image: "assets/images/img_1.png"),
    Category(title: "Ambulance", image: "assets/images/img_2.png"),
    Category(title: "Fire Fighter", image: "assets/images/img_3.png"),
  ];
}
