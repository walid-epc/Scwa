class ImagesModel{
String filePath;

ImagesModel({this.filePath});
  factory ImagesModel.fromJson(Map<String,dynamic> jsonData){
    return ImagesModel(
        filePath: jsonData['file_path'],

    );
  }
}