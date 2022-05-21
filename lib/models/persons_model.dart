class PersonsModel {
  final int id;
  final String name;
 final String imageUrl;
  final String department;
  final int gender;

  PersonsModel(
      { this.id,
       this.department,
       this.imageUrl,
       this.name,
       this.gender});

  factory PersonsModel.fromJson(Map<String, dynamic> jsonData) {
    return PersonsModel(
      id: jsonData['id'],
      department: jsonData['known_for_department'],
      imageUrl: jsonData['profile_path'],
      name: jsonData['name'],
      gender: jsonData['gender'],
    );
  }

  @override
  String toString() {
    return 'id = $id name=$name depart=$department image = $imageUrl gender=$gender';
  }
}
