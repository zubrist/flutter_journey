import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( 
      backgroundColor: Colors.deepPurple[400]),
      // body: const Image(
      //   height: 300,width: 600,
      //   // height: double.infinity, width: double.infinity,

      //   // fit: BoxFit.scaleDown,
      //   // repeat: ImageRepeat.repeatX,

      //   alignment: Alignment.bottomLeft,
      //   // fetching the image from code base
      //   // image: AssetImage('assets/images/image1.jpg'),

      //   // fetching the image from interne
      //   image: NetworkImage('https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0'),
      // )

      body: const CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage('https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0'),
      ),
    );
  }
}