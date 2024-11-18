import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_app/models/profile_model.dart';
import 'package:student_app/profile/myprofile.dart';


class EditProfile extends StatefulWidget{
  final UserProfile userProfile;
  const EditProfile({required this.userProfile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey=GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobController;
  late TextEditingController _dobController;
  @override
  void initState(){
    super.initState();
    _nameController=TextEditingController(text: widget.userProfile.name);
    _emailController=TextEditingController(text: widget.userProfile.email);
    _mobController=TextEditingController(text: widget.userProfile.mobile);
    _dobController=TextEditingController(text: widget.userProfile.dob);
    }
  @override
  void dispose(){
_nameController.dispose();
_emailController.dispose();
_mobController.dispose();
_dobController.dispose();
      super.dispose();
    }
    void _updateProfile(){
    setState(() {
      widget.userProfile.name=_nameController.text;
      widget.userProfile.email=_emailController.text;
      widget.userProfile.mobile=_mobController.text;
      widget.userProfile.dob =_dobController.text;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile updated Successfully")));
    });
    Navigator.pop(context,widget.userProfile);
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(
         icon: const Icon(Icons.arrow_back),
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => const Myprofile(),));
         },
       ),
       backgroundColor:Colors.blue[300],
       centerTitle: true,
       title: const Text("Edit Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
     ),
     body: Padding(
       padding: const EdgeInsets.all(16),
       child: Form(
         key: _formKey,
         child: Column(
           //mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const Text("Name"),
             TextFormField(
               controller: _nameController,
               decoration: const InputDecoration(
                 border:OutlineInputBorder(),

               ),
             ),
         const SizedBox(height: 10),
         const Text("Email"),
         TextFormField(
           controller: _emailController,
           decoration: const InputDecoration(
             border:OutlineInputBorder(),

           ),
         ),
             const SizedBox(height: 10),
             const Text("Mobile No"),
             TextFormField(
               controller: _mobController,
               decoration: const InputDecoration(
                 border:OutlineInputBorder(),

               ),
             ),
             const SizedBox(height: 10),
             const Text("Date of Birth"),
             TextFormField(
               controller: _dobController,
               decoration: const InputDecoration(
                 border:OutlineInputBorder(),

               ),
             ),
             const SizedBox(height: 15),
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
             children: [
             ElevatedButton(
                 onPressed:_updateProfile,
                 style: ElevatedButton.styleFrom(
                   shape: const StadiumBorder(),
                   padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 60),
                   backgroundColor:Colors.blue,
                 ),
                 child:const Text("Update Profile",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black))
             ),
       ],
             ),

           ],
         ),
       ),
     ),
   );
  }
}
