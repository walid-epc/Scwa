import 'package:flutter/cupertino.dart';
import 'package:popular_people_cloud/models/persons_model.dart';
import 'package:popular_people_cloud/models/results_model.dart';
import 'package:popular_people_cloud/services/persons_api.dart';

class ResultsViewModel extends ChangeNotifier {
  List<PersonsModel> personsList = [];
  int page = 1;
  int totalPages;
  int totalResults;
  int pageNum;

  Future<void> fetchResults() async {
    var newData = await PersonsApi().fetchJsonResult(page);
    ResultsModel results = ResultsModel();
    var persons = newData.results.map((e) => PersonsModel.fromJson(e)).toList();
    totalPages = newData.totalPages;
    totalResults = newData.totalResults;
    pageNum = newData.page;
    personsList.addAll(persons);
    page++;
    print('pageeeeeeeeeeeee $page');
    notifyListeners();
  }

  List<PersonsModel> get perList => personsList;
  int get totalPage => totalPages;
  int get totalResult => totalResults;
  int get pageNumber => pageNum;
}
