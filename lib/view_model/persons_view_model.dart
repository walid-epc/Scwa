import 'package:flutter/cupertino.dart';
import 'package:popular_people_cloud/models/persons_model.dart';
import 'package:popular_people_cloud/services/persons_api.dart';

// class PersonsViewModel extends ChangeNotifier {
//   List<PersonsModel> personsList = [];
//   int page = 1;
//
//   Future<void> fetchPersons() async {
//     var newData = await PersonsApi().fetchJsonData(page);
//     // personsList.addAll(newData);
//     page++;
//     print('pageeeeeeeeeeeee $page');
//     notifyListeners();
//   }
//
//   List<PersonsModel> get perList => personsList;
// }
