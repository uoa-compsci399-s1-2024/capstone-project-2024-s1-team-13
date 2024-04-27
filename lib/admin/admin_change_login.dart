import 'package:flutter/material.dart';

class AdminChangeLogin extends StatefulWidget {
  AdminChangeLogin({super.key, required this.title});
  final String title;

  @override
  _AdminChangeLoginState createState() => _AdminChangeLoginState();
}

class _AdminChangeLoginState extends State<AdminChangeLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
              iconSize: 40,
              icon: Icon(Icons.arrow_back_ios),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
              onPressed: () {
                //Pending backend functionality - should save edits
                Navigator.pop(context);
              },
              iconSize: 50,
              icon: Icon(Icons.done_rounded),
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
            ),
          ],
        ),

        // Body of screen
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            children: [_LoginType(), SizedBox(height: 50), _LoginDetails()],
          ),
        ));
  }

  // Drop Down List -  for login type
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Admin"), value: "Admin"),
      DropdownMenuItem(child: Text("Support"), value: "Support"),
    ];
    return menuItems;
  }

  late String selectedValue = "Admin";
  Widget _LoginType() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login Type",
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
          DropdownButtonFormField(
              itemHeight: 75,
              value: selectedValue,
              items: dropdownItems,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              elevation: 2,
              dropdownColor: Colors.grey[100],
              icon:
                  Visibility(visible: false, child: Icon(Icons.arrow_downward)),
              style: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.arrow_drop_down_circle_rounded,
                    color: Colors.pink[900], size: 40),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Colors.grey[300],
              )),
        ],
      );

  // Login Details - username and password text controllers
  Widget _LoginDetails() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Username
        Text(
          "Username",
          style: TextStyle(
            fontFamily: "Lexend Exa",
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
            controller: _usernameController,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter username",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
        SizedBox(height: 30),

        // Password
        Text(
          "Password",
          style: TextStyle(
              fontFamily: "Lexend Exa",
              fontSize: 30,
              fontWeight: FontWeight.w500),
        ),
        TextFormField(
            controller: _passwordController,
            style: TextStyle(
                fontFamily: "Lexend Exa",
                fontSize: 30,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              filled: true,
              fillColor: Colors.grey[300],
              hintText: "Enter password",
              hintStyle: TextStyle(
                  fontFamily: "Lexend Exa",
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
            )),
      ]);
}
