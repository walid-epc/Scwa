import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:popular_people_cloud/constrain.dart';
import 'package:popular_people_cloud/models/details_model.dart';
import 'package:popular_people_cloud/models/images_mode.dart';
import 'package:popular_people_cloud/models/person_images_model.dart';
import 'package:popular_people_cloud/models/persons_model.dart';
import 'package:popular_people_cloud/models/results_model.dart';

class PersonsApi {

  List<PersonsModel> personsList = [];
  var newList;
  Future<List<PersonsModel>> fetchJsonData(page) async {
    try {
      var fullUrl = url +
          '/person/popular' +
          apiKey +
          language +
          '&page=' +
          page.toString();

      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        var body = response.body;
        var jsonData = jsonDecode(body);
        ResultsModel results = ResultsModel.fromJson(jsonData);
        newList = results.results.map((e) => PersonsModel.fromJson(e)).toList();
        personsList.addAll(newList);
        return personsList;
      } else {
        // print(jsonData['message']);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<DetailsModel> fetchPersonDetails(id) async {


    try {
      var fullUrl = url + '/person/' + id.toString() + apiKey + language;
      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        var body = response.body;
        var jsonData = jsonDecode(body);
        DetailsModel results = DetailsModel.fromJson(jsonData);

        return results;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<ImagesModel>> fetchPersonImages(id) async {


    try {
      var fullUrl = url + '/person/' + id.toString() + '/images' + apiKey;

      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        var body = response.body;
        var jsonData = jsonDecode(body);
       PersonImagesModel images = PersonImagesModel.fromJson(jsonData);
       List<ImagesModel> imagesList = images.profiles.map((e) => ImagesModel.fromJson(e)).toList();

        return imagesList;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
