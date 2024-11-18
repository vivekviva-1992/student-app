import 'package:flutter/material.dart';
import 'package:student_app/courses/course_view.dart';
import 'package:student_app/models/course_model.dart';
import 'package:student_app/db_services/dbservices.dart';
import 'package:intl/intl.dart';
import 'package:student_app/courses/fav_courses.dart';
import 'package:student_app/profile/myprofile.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  List<CourseModel> _courseList=[];
  final DatabaseHelper _dbHelper=DatabaseHelper();
  @override
  void initState(){
    super.initState();
    _loadTasks();
  }
  Future<void> _loadTasks() async{
    final courses=await _dbHelper.courseModel();
    setState(() {
      _courseList=courses;
    });
  }
  void  toggleFavorite(int index)
  async
  {
    setState(() {
      _courseList[index].isFavorite=! _courseList[index].isFavorite;
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon:const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CourseView(),));
            },
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Courses View",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        ),
        body:_courseList.isEmpty?
        Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),

              height: MediaQuery.of(context).size.height-50,
              width: double.infinity,

              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  SizedBox(height: 60.0,width: 60.0),
                  Text("Course List",
                    style:TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C1D45),
                    ),
                  ),
                  SizedBox(
                    height: 150,

                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(Icons.inbox,
                          size: 100,
                          color: Color(0xFF6C1D45),
                        ),
                        SizedBox(height: 10),

                        Text("No courses added",
                          style: TextStyle(fontSize: 18,color: Color(0xFF6C1D45),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0,width: 20.0),
            const Text("Course List",
              style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C1D45),
              ),
            ),
            Expanded (
              child:ListView.builder(
                physics:const BouncingScrollPhysics(),
                itemCount: _courseList.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context,index){
                  DateTime courseDate=DateTime.now();
                  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
                  String formattedDate = dateFormat.format(courseDate);

                  return InkWell(
                    onTap: (){
                    },
                    child:Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: Color(0xFF6C1D45),
                              width: 1
                          )
                      ),
                      margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                      child: ListTile(
                        title: Text(_courseList[index].title,
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF6C1D45)),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Student Name:${_courseList[index].firstname}'),
                            Text('Course Category:${_courseList[index].category}'),
                            Text('Date:$formattedDate',style:const TextStyle(fontSize: 16,color: Colors.black),
                            ),
                          ],
                        ),
                        trailing:
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                _courseList[index].isFavorite ?
                                    Icons.favorite:Icons.favorite_border,
                                color:
                                _courseList[index].isFavorite ? Colors.red:Colors.grey,
                              ),
                              onPressed: ()=>toggleFavorite(index),
                            ),
                            IconButton(
                                onPressed: (){
                                  _dbHelper.deleteCourse(_courseList[index].id!);
                                },
                                icon:const Icon(Icons.delete)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const CourseView(),));
                },
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Myprofile(),));
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
