// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AccountScreen extends StatefulWidget {
//   const AccountScreen({super.key});

//   @override
//   State<AccountScreen> createState() => _AccountScreenState();
// }

// class _AccountScreenState extends State<AccountScreen> {
//   final user = FirebaseAuth.instance.currentUser!;
//   late Future<Map<String, String?>> userData;

//   Future<Map<String, String?>> getData() async {
//     DocumentSnapshot snap = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();

//     if (snap.exists) {
//       Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
//       return {
//         "name": data["name"] as String?,
//         "email": data["email"] as String?,
//         "phone": data["phone"] as String?,
//       };
//     } else {
//       return {
//         "name": null,
//         "email": null,
//         "phone": null,
//       };
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     userData = getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Center(
//           child: const Text(
//             'User Account',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.amber,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Account Info',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 35,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
//                   child: CircleAvatar(
//                     backgroundImage: AssetImage('images/user_icon.png'),
//                     maxRadius: 45.0,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Basic Info',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 FutureBuilder<Map<String, String?>>(
//                   future: userData,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (snapshot.hasData) {
//                       final data = snapshot.data!;
//                       return Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: ListTile(
//                               title: Text(
//                                 'Name',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 data["name"] ?? "No name available",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w300,
//                                     fontFamily: "Signatra",
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: ListTile(
//                               title: Text(
//                                 'Email',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 data["email"] ?? "No email available",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: "Signatra",
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: ListTile(
//                               title: Text(
//                                 'Phone',
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 data["phone"] ?? "No phone number available",
//                                 style: TextStyle(
//                                     fontSize: 18,
//                                     fontFamily: "Signatra",
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.arrow_forward_ios,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     } else {
//                       return Text('No data available');
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
