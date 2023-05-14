// import 'package:cloud_firestore/cloud_firestore.dart';
//
// void createTeam() async {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   // Add a new document to the teams collection with the teamName and teamLogo fields
//   List<Map<String, dynamic>> teamData =
//   [
//     {
//     'teamName': 'Lahore Qalandars',
//     'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/lahore.png',
//     },
//     {
//       'teamName': 'Peshawar Zalmi',
//       'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/peshawar.png',
//     },
//     {
//       'teamName': 'Islamabad United',
//       'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/islamanabd.png',
//     },
//     {
//       'teamName': 'Multan Sultan',
//       'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/multan.png',
//     },
//     {
//       'teamName': 'Quetta Gladiators',
//       'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/quetta.png',
//     },
//     {
//       'teamName': 'Karachi Kings',
//       'teamLogo': '/Users/humashehwana/Documents/FYP/App/Assets/karachi.png',
//     },
//   ];
//
//   CollectionReference teamsCollection = firestore.collection('teams');
//   for (var teamData in teamsData) {
//     await teamsCollection.add(teamData);
//   }
//   // print('New team document created with ID: ${newTeamDocRef.id}');
// }
// createTeam()