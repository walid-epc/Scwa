class ResultsModel{
  List<dynamic> results;
  int page;
  int totalResults;
  int totalPages;

  ResultsModel({this.results, this.page, this.totalPages, this.totalResults});
  factory ResultsModel.fromJson(Map<String,dynamic> jsonData){
    return ResultsModel(
      results: jsonData['results'],
      page: jsonData['page'],
      totalPages: jsonData['total_pages'],
      totalResults: jsonData['total_results']
    );
  }
}