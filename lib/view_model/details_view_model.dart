import 'package:flutter/cupertino.dart';
import 'package:popular_people_cloud/models/details_model.dart';
import 'package:popular_people_cloud/services/persons_api.dart';

class DetailsViewModel extends ChangeNotifier{
  DetailsModel details;
  Future<void> fetchDetails(id) async {
     details = await PersonsApi().fetchPersonDetails(id);
     notifyListeners();
  }

  DetailsModel get detail =>details;


}