import 'package:flutter/material.dart';

class RecordAddress extends StatelessWidget {
  RecordAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Transform.scale(
                scale: 1.2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/Rectangl.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    TextField(),
                    SizedBox(height: 10.0),
                    TextField(),
                    SizedBox(height: 10.0),
                    TextField(),
                    SizedBox(height: 10.0),
                    TextField(),
                    SizedBox(height: 10.0),
                    TextField(),
                    SizedBox(height: 10.0),
                    TextField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
