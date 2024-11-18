import 'package:flutter/material.dart';

import 'package:student_app/courses/course_view.dart';
import 'package:student_app/courses/my_courses.dart';
import 'package:student_app/models/course_model.dart';
import 'package:student_app/db_services/dbservices.dart';
import 'package:intl/intl.dart';

class FavCourseView extends StatelessWidget {
  final List<CourseModel> courseList;
  FavCourseView({required this.courseList});

  @override
  Widget build(BuildContext context) {
    final  List<CourseModel> favCourses=courseList.where((course)=>course.isFavorite).toList();
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        leading: IconButton(
        icon:const Icon(Icons.arrow_back),
    onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCoursesView(),));
    },
    ),
    backgroundColor: Colors.blue,
    centerTitle: true,
    title: const Text("My Courses",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    ),
          body: favCourses.isEmpty
          ? const Center(
            child: Text('No Favorites Courses Found',
              style: TextStyle(color: Colors.red,fontSize: 20),
            )
          ):
          Column(
            children: [
              Expanded(
                  child:ListView.builder(
                    physics:const BouncingScrollPhysics(),
                      itemCount: favCourses.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder:(context,index){
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
                    child:ListTile(
                    title: Text("Course Name:${
                      favCourses[index].title}",
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Course Category:${favCourses[index].category}"),
                      Text("Date:$formattedDate"),
    ],
                    ),
                    trailing:
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed:(){},
                              icon:const Icon(Icons.favorite,
                              color: Colors.red)
                          ),
                        ],
                      )

                  ),
                    ),
                    );
                  }
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

                  },),
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
