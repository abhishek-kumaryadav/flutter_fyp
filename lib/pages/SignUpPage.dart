import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/providers.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final aadharController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // if (ref.read(userProvider).value != null) {
    //   // ref.read(firebaseAuthProvider).signOut();
    //   Navigator.pushReplacementNamed(context, "/home");
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('../../asset/images/VNIT_logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: aadharController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Aadhar ID',
                    hintText: 'Enter valid Aadhar id'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter valid password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              // padding: EdgeInsets.only(top: 20),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  // Navigator.push(
                  // context, MaterialPageRoute(builder: (_) => HomePage()));
                  print(emailController.text);
                  print(passwordController.text);
                  print(aadharController.text);
                  await ref
                      .read(firebaseAuthProvider)
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                  final uid = ref.read(firebaseAuthProvider).currentUser!.uid;
                  print("Logged in");
                  print("Logged in with user: " + uid);
                  await ref
                      .read(firebaseDatabaseProvider)
                      .ref("users/" + uid)
                      .set({"aadhar": aadharController.text});
                  print("Created entry in database");

                  // DatabaseReference reference = FirebaseDatabase.instance
                  //     .ref(aadharNumber)
                  //     .child(element.item1)
                  //     .child(element.item2);
                  // reference.set(!element.item3);
                  // print("pushed user to database");
                  // Navigator.pushNamed(context, "/home");11
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            GestureDetector(
              child: Text('Already a User? Log In'),
              onTap: () {
                ref.read(uiStateProvider.notifier).state = UiState.Login;
              },
            )
          ],
        ),
      ),
    );
  }
}
