
import 'package:flutter/material.dart';
import 'package:student_app/courses/fav_courses.dart';
import 'package:student_app/courses/my_courses.dart';
import 'package:student_app/models/course_model.dart';
import 'package:student_app/profile/myprofile.dart';
import 'package:student_app/db_services/dbservices.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  final DatabaseHelper _dbHelper=DatabaseHelper();
  final TextEditingController _firstnameController=TextEditingController();
  final TextEditingController _lastnameController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _idController=TextEditingController();
  String? _selectGender;
  String? _selectedCourse;
  String? _selectedCategory;
  List<String> _courses=['Btech','MCA','MBA','BBA','Inter','SSC','BCA'];
  List<String>_categories=['ECE','EEE',"IT","CSE",'Marketing','Finance','HR','MPC',"CEC","Bipc"];

  List<CourseModel> _courseList=[];
  @override
  void initState(){
    super.initState();
    _loadCourses();
  }
  Future<void>_loadCourses() async{
    final courses=await _dbHelper.courseModel();
    print("Courses fetched from DB:${courses.length}");
    setState(() {
      _courseList=courses;
    });
  }
Future<void>_addCourse()async{
final firstname=_firstnameController.text.trim();
final lastname=_lastnameController.text.trim();
final gender=_selectGender;
final email=_emailController.text.trim();
final coursename=_selectedCourse;
final category=_selectedCategory;
final studentid=_idController.text.trim();
if(firstname.isNotEmpty && lastname.isNotEmpty && email.isNotEmpty && studentid.isNotEmpty && gender !=null&& coursename != null&&category != null){
  await _dbHelper.insertCourse(
    CourseModel(
        firstname: firstname,
        lastname: lastname,
        gender: gender,
        email: email,
        studentid: studentid,
        title: coursename,
        category: category,
        ));
_firstnameController.clear();
_lastnameController.clear();
_idController.clear();
_emailController.clear();
  _loadCourses();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Course Added successfully!'),
      duration: Duration(seconds: 2),
    ),
  );
}
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF6EEE2)),
      title: "Course Registration",
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(Icons.grid_view_sharp),
            onPressed: (){},
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Myprofile(),));
              },
              child:const  CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg',),
                radius: 35,
              ),
            ),
          ],
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text("Course Registration",style: TextStyle(fontFamily: '',fontSize: 26,fontWeight: FontWeight.bold),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
              children:[
                CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/icons/students logo.png'),
                  ),
            ],
                ),
                const Text('Welcome to the Student Portal',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                const SizedBox(height: 10),
                const Text("Student Name",
                style: TextStyle(fontSize: 16,color: Colors.purple),),
                Row(
                  children: [
                    Expanded(child:
                    TextFormField(
                      controller: _firstnameController,
                      decoration: InputDecoration(
                labelText: 'First name',
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    )
                      ),
                      validator: (value){
                        if(value ==null||value.isEmpty){
                          return 'Please enter first name';
                        }
                        return null;
                      },
                    ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(child:
    TextFormField(
      controller: _lastnameController,
    decoration: InputDecoration(
    labelText: 'Last Name',
    border:OutlineInputBorder(
    borderRadius: BorderRadius.circular(1),
    )
    ),
    validator: (value){
    if(value ==null||value.isEmpty){
    return 'Please enter Last name';
    }
    return null;
    },
    ),
    ),

              ],
            ),
                const SizedBox(height: 16),
                const Text("Gender",
                style: TextStyle(fontSize: 16,color: Colors.purple),
                ),
                DropdownButtonFormField<String>(

                  value: _selectGender,
                  hint: const Text("Please Select"),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectGender=newValue;
                    });
                  },
                  validator: (value)=>value==null?'Please select gender':null,
                  items:
                  ['Male',"Female",'other'].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),

                    );
                  }).toList(),
                ),
                const SizedBox(height: 5),
                const Text('Student E-mail',
                style: TextStyle(fontSize: 16,color: Colors.purple),),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1)
                      ),
                    labelText: "myname@example.com"

                  ),
                  validator: (value){
                    if(value==null ||value.isEmpty){
                      return 'please enter your email';
                    }
                    return null;
                    }
                ),
                const SizedBox(height: 5),
                const Text('Student ID',style: TextStyle(fontSize: 16,color: Colors.purple),
                ),
                TextFormField(
                  controller: _idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1)
                    ),
                    labelText: 'Enter your ID',
                  ),
                    validator: (value){
                      if(value==null ||value.isEmpty){
                        return 'please enter your ID';
                      }
                      return null;
                    }
                ),
        const SizedBox(height:5),
            const Text("Courses",style: TextStyle(fontSize: 16,color: Colors.purple),),
                DropdownButtonFormField<String>
                  (value: _selectedCourse,
                    hint: const Text('Please select course'),
                    onChanged: (String ? newValue){
                    setState(() {
                      _selectedCourse=newValue;
                    });
                    },
                  validator: (value)=> value==null?'Please select a course':null,
                  items:
                    _courses.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                    value: value,
                        child: Text(value),
                      );

                    }).toList(),
                ),
    const SizedBox(height: 10),
                const Text("Categories",style: TextStyle(fontSize: 16,color: Colors.purple),),
    Expanded(
        child:
        DropdownButtonFormField<String>
          (value: _selectedCategory,
          hint: const Text('Please select category'),
          onChanged: (String ? newValue){
            setState(() {
              _selectedCategory=newValue;
            });
          },
          validator: (value)=> value==null?'Please select a category':null,
          items:
          _categories.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );

          }).toList(),
        ),
    ),
    const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _addCourse,
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                          backgroundColor:Colors.blue),
                      child: const Text("Add Course",
                          style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    ElevatedButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const  MyCoursesView(),));
                    },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                          backgroundColor:Colors.blue),
                      child:const Text("View Course",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
    ),
          ),
      ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.orange[500],
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              IconButton(
                icon: const Icon(Icons.grid_view,
                    size: 24),
                onPressed:(){},
                color: Colors.black,
              ),
              IconButton(
                icon: const Icon(Icons.favorite_outline,
                  size: 24,
                  color: Colors.black,
                ),
                onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>FavCourseView(courseList:_courseList),));
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed:(){},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed:(){
                },
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
