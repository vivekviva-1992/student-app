
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_app/courses/course_view.dart';
import 'package:student_app/views/register_view.dart';
import 'package:student_app/db_services/userdbservice.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final Dbservice dbservice=Dbservice();
  final TextEditingController _usercontroller=TextEditingController();
  final TextEditingController _passwordcontroller=TextEditingController();

  void _login() async{
    String username=_usercontroller.text;
    String password=_passwordcontroller.text;
    var student=await dbservice.getUser(username, password);
    if(student!=null){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const CourseView(),));
    }
    else{
      showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Login Failed'),content: const Text('Incorrect username or password'),
        actions: <Widget>[ElevatedButton(onPressed: ()=>Navigator.pop(context),child:const Text('Ok'))],
      ),

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(scaffoldBackgroundColor: const Color(0xFFF6EEE2)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Student App",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            key: _formKey,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height-50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Column(
                  children: <Widget>[
                    SizedBox(height: 50.0,width: 70.0),
                    Text("Login",
                      style:TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C1D45),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Welcome to Student App!",
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    const Text('Email',
                      style: TextStyle(fontSize: 16,color: Color(0xFF6C1D45)),
                    ),
                    TextField(
                      controller: _usercontroller,
                      decoration: InputDecoration(
                        //hintText: "Email",
                          border:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(18.0),
                              borderSide: BorderSide.none
                          ),
                          fillColor:Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)
                      ),

                    ),
                    const SizedBox(height: 20),
                    const Text('Password',
                      style: TextStyle(fontSize: 16,color: Color(0xFF6C1D45)),
                    ),
                    TextField(

                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                        //hintText: "Password",
                          border:OutlineInputBorder(
                              borderRadius:BorderRadius.circular(18.0),
                              borderSide: BorderSide.none
                          ),
                          fillColor:Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password)
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 80,left: 25),
                  child: ElevatedButton(
                    onPressed:_login,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 10),
                      backgroundColor:Colors.blue,
                    ),child: const  Text("Login",
                    style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                  ),

                  ),

                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView(),));
                        },
                        child: const Text("Register", style: TextStyle(color: Colors.purple),)
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],

            ),

          ),
        ),
      ),
    );
  }
}
