import 'package:popular_people_cloud/models/images_mode.dart';

class PersonImagesModel {

  List<dynamic> profiles;

  PersonImagesModel({this.profiles});

  factory PersonImagesModel.fromJson(Map<String, dynamic> jsonData) {
    return PersonImagesModel(
        profiles: jsonData['profiles'],
    );
  }

  static List<String> listToString(List<dynamic> list) {
    return List<String>.from(list);
  }

  @override
  String toString() {
    return ' imageList = $profiles';
  }
}
