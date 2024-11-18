

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:student_app/views/login_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:student_app/models/user_model.dart';
import 'package:student_app/api_services/api_service.dart';
import 'package:student_app/db_services/userdbservice.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}
class _RegisterViewState extends State<RegisterView> {
  final _formKey=GlobalKey<FormState>();
  final Dbservice dbservice=Dbservice();
  Int? id;
  final _firstnameController=TextEditingController();
  final _lastnameController=TextEditingController();
  final _emailController=TextEditingController();
  final _mobileController=TextEditingController();
  final _dobController=TextEditingController();
  final _passController=TextEditingController();
 // String? _selectGender;
  bool _isLoading=false;
  void  _submitForm()async{
    Student student=Student(firstname: _firstnameController.text.trim(), lastname: _lastnameController.text.trim(), email: _emailController.text.trim(), password: _passController.text.trim());
    
    var result=await dbservice.createuser(student);
    print(result);
    if (result>0){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginView(),));
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF6EEE2)),
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text("Student App",style: TextStyle(fontFamily: '',fontSize: 30,fontWeight: FontWeight.bold),
        ),
            ),
        body:SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            key: _formKey,
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:<Widget> [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const CircleAvatar(
              radius: 60,
                backgroundImage: AssetImage('assets/icons/students logo.png'),

              ),
            ),
              const SizedBox(height: 10),
              const Text('Create Account',
              style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              const Text('First Name',style: TextStyle(color: Colors.purple),),
              TextField(
                controller: _firstnameController,
                decoration:const InputDecoration(
                  //labelText: 'First Name',
                  border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.person)
                  ),

                ),
              const SizedBox(height: 10),
                const Text('Last Name',style: TextStyle(color: Colors.purple)),
              TextField(
                controller: _lastnameController,
                decoration:const InputDecoration(

                  //labelText: 'Last Name',
                  border: OutlineInputBorder(),
                    prefixIcon:  Icon(Icons.person)
                ),
              ),
              const SizedBox(height: 10),
                const Text('Email',style: TextStyle(color: Colors.purple)),
              TextField(
                controller: _emailController,
                decoration:InputDecoration(
                  //labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(1),
                    borderSide:const BorderSide(
                        color: Colors.orange,
                      width: 2
                    ),
                  ),
                    prefixIcon:const  Icon(Icons.email)

                ),

              ),
              const SizedBox(height: 10),
                const Text('Mobile',style: TextStyle(color: Colors.purple)),
              TextField(
                controller: _mobileController,
                decoration:const InputDecoration(
                  //labelText: 'Mobile',
                  border:OutlineInputBorder(

                  ),
                    prefixIcon:Icon(Icons.call)
                ),
              ),
              const SizedBox(height: 10),
                const Text('Date of Birth',style: TextStyle(color: Colors.purple)),
              TextField(
                controller: _dobController,
                decoration:const InputDecoration(
                  //labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.calendar_today)
                ),
              ),
              const SizedBox(height: 10),
                const Text('Password',style: TextStyle(color: Colors.purple)),
                TextField(
                  controller: _passController,
                decoration:const InputDecoration(
                  //labelText: 'Password',
                  border: OutlineInputBorder(),
                    prefixIcon:Icon(Icons.password)
                ),
                  obscureText: true,
              ),
              const SizedBox(height: 10),
              ],
          ),
              const SizedBox(height: 10),
              _isLoading?const Center(child: CircularProgressIndicator()):
              Container(
                padding: const EdgeInsets.only(top: 25,left: 25,right: 25),
                child: ElevatedButton(
                  onPressed:_submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 80),
                    backgroundColor:Colors.blue,
                  ),child: const  Text("Register",
                  style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
                ),

                ),

              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>const LoginView(),));
                      },
                      child: const Text("Login", style: TextStyle(color: Colors.purple),)
                  ),
                ],
              ),
        ],
          ),
          ),
          ),
      ),
    );
  }
}
