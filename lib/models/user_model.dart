
class Student{
  final int? id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  Student ( {this.id, required this.firstname,required this.lastname,required this.email, required this.password
  });
  factory Student.fromMap(Map<String,dynamic> json)=>Student(
    id:json["id"],
    firstname: json["firstname"],
    lastname: json['lastname'],
    email: json["email"],
    password: json["password"],
  );
  Map<String,dynamic>toMap()=>{
    "firstname":firstname,
    "lastname":lastname,
    "email":email,
    "password":password,
  };
}