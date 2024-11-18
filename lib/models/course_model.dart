
class CourseModel {
  final int? id;
  final String firstname;
  final String lastname;
  final String gender;
  final String email;
  final String title;
  final String category;
  final String studentid;
  bool isFavorite;

  CourseModel(
      {this.id, this.isFavorite=false,required this.firstname, required this.lastname, required this.gender, required this.email, required this.title,required this.category,required this.studentid});

  factory CourseModel.fromMap(Map<String, dynamic> json)=>
      CourseModel(
          id: json['id'],
          firstname: json['firstname'],
          lastname: json['lastname'],
          gender: json['gender'],
          email: json['email'],
          title: json['title'],
          category: json['category'],
          studentid: json['studentid'],
      );
    Map<String,dynamic>toMap(){
    return{
      "id":id,
      "firstname":firstname,
      "lastname":lastname,
      "gender":gender,
      "email":email,
      "title":title,
      "category":category,
      "studentid":studentid
    };
  }
}