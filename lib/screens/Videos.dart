import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:lab7/models/UserInfo.dart' as User;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab7/Database/database.dart';

import 'package:lab7/screens/analysis.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  List<Videos> videos = [];
  @override
  initState(){
    super.initState();
    fetchVideosList();
  }

  Future<String> sendVideoFile(path) async {
    print("send file is called");
    print(path);
    final file = File(path);
    final videoBytes = file.readAsBytesSync();

    final url = Uri.parse('http://192.168.100.12:10000');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('video', file.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print("response has arrived");
    print(responseBody);
    final jsonResponse = jsonDecode(responseBody);
    final battingStyle = jsonResponse['Batting style'];
    final bowlingType = jsonResponse['Bowling type'];

    print('Batting style: $battingStyle');
    print('Bowling type: $bowlingType');
    return battingStyle + "/" + bowlingType;
  }

  fetchVideosList() async {
    dynamic Videosfromdb = await DatabaseManager().getVideos();

    if (Videosfromdb == null) {
      print("Unable to get teams data");
    }

    else {
      print(Videosfromdb);

      setState(() {
        print("getting data");
        for (MapEntry<String, Map<String, dynamic>> video in Videosfromdb.entries) {
          Videos video_data =Videos(

              video.value['video'] ?? '',
              video.value['url'] ?? '',
              video.value['userid']  ?? '',
              video.value['ball_type']?? '',
              video.value['bat_type']??'',
          );
          videos.add(video_data);
          print(videos);

        }

      });

    }
  }


  final videosRef = FirebaseFirestore.instance.collection('Videos');

  Future<bool> checkIfFileExists(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    try {
      await ref.getDownloadURL();
      return true;
    } catch (e) {
      return false;
      }
    }


  Future<String> _uploadVideoToFirestore(String path, String uid) async {
    File videoFile = File(path);

    try {
      String fileName = basename(videoFile.path);

      final reference = FirebaseStorage.instance.ref().child('videos/$uid/$fileName');
      final isFileExisting =  await checkIfFileExists('videos/$uid/$fileName');
      if (isFileExisting) {
        String url= await reference.getDownloadURL();
        print('File already exists');
        return url;
      } else {
        UploadTask uploadTask = reference.putFile(videoFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        print('Video uploaded to Firestore: $downloadURL');
        return downloadURL;
        }
    } catch (e) {
        print('Error uploading video to Firestore: $e');
        return "";
        }
   }


  Future<void> _pickFile(userid) async {

    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("picked file not null");
      print(videos);
      setState(() {
        var contain = videos.where((element) => (element.path == pickedFile.path && element.userid==userid!));
        if (contain.isEmpty)
          videos.add(Videos(pickedFile.path,"",userid,"",""));
        else
          print("file already added");


        // print(videos);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User.UserInfo?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Videos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async=>await _pickFile(user!.uid!),
          ),
        ],
      ),
     body: videos.isEmpty
      ? Center(
        child: Text('No videos uploaded',style: TextStyle(color: Colors.white60),),
      ): ListView.builder(
            itemCount: videos.where((video) {
            return video.userid == user!.uid!;}).length,
            itemBuilder: (context, index) {
              final filteredVideos = videos.where((video) => video.userid == user!.uid).toList();

              final thumbnail = filteredVideos[index];


                  return ListTile(
                    // leading: Image.memory(thumbnail.thumbnailData),
                    leading: Text(
                      thumbnail.path.split("/").last,
                      style: TextStyle(color: Colors.white70),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        print("Analyze");

                        String url_link = await _uploadVideoToFirestore(
                            thumbnail.path, user!.uid!);


                        final query = videosRef.where('video_name', isEqualTo: thumbnail.path.split("/").last).where('userid',isEqualTo: user.uid);

                        final querySnapshot = await query.get();

                        if (querySnapshot.docs.isNotEmpty) {
                          final firstDoc = querySnapshot.docs.first;
                          print("Video already in db");
                          // Document exists, do something with the document
                        } else {
                          String response=await sendVideoFile(thumbnail.path);
                          String ball_type=response.split("/")[0];
                          print(ball_type);
                          String bat_type=response.split("/")[1];
                          print(bat_type);
                          await videosRef.add({
                            'userid': user.uid,
                            'video_name': thumbnail.path.split("/").last,
                            'url': url_link,
                            'ball_type': ball_type,
                            'bat_type': bat_type,

                          });
                        }

                        fetchVideosList();
                        setState(() {
                          videos=[];
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AnalysisPage(
                              videoUrl: url_link,
                              ballType: thumbnail.ball_type,
                              batType: thumbnail.bat_type,
                            ),
                          ),
                        );
                      },
                      child: Text('Analyze'),

                    ),

                  );

              },
        ),

    );
  }
}


class Videos {

  final String path;

  final String ball_type;
  final String bat_type;
  final String userid;
  final String url;

  Videos(path,url,userid,ball_type,bat_type):
    path=path,
    userid=userid,
    url=url,
    ball_type= ball_type,
    bat_type=bat_type;

    // thumbnailData=thumbnailData;
}