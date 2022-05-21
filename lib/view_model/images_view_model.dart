import 'package:flutter/cupertino.dart';
import 'package:popular_people_cloud/models/images_mode.dart';
import 'package:popular_people_cloud/services/persons_api.dart';

class ImagesViewModel extends ChangeNotifier {

  List<ImagesModel> imagesList ;
  Future<void> fetchPersonImages(id) async {
    imagesList = await PersonsApi().fetchPersonImages(id);

    notifyListeners();
  }

  List<ImagesModel> get imgList => imagesList;
}
