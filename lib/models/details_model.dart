class DetailsModel{
  String name;
  String birthday;
  String biography;
  DetailsModel({this.name,this.biography,this.birthday});

  factory DetailsModel.fromJson(Map<String,dynamic> jsonData){
    return DetailsModel(
      name: jsonData['name'],
      birthday: jsonData['birthday'],
      biography: jsonData['biography']
    );
  }

}