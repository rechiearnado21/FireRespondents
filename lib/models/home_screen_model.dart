class HomeScreenModel {
  final String? type;
  final String? image;
  final bool? isInjured;
  final String? description;

  HomeScreenModel({this.type, this.image, this.isInjured, this.description});

  // Storage for all reports
  List<HomeScreenModel> reports = [];
}
