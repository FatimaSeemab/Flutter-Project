import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:io';

class AnalysisPage extends StatefulWidget {
  final String videoUrl;
  final String ballType;
  final String batType;

  const AnalysisPage({Key? key, required this.videoUrl, required this.ballType, required this.batType}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          // _controller.setLooping(true);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
      ),
      body: Column(
        children: [
          Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                 child: VideoPlayer(_controller),
          )
              : CircularProgressIndicator(),
        ),
        SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Ball Type: ${widget.ballType}',style: TextStyle(color:Colors.white70),),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Bat Type: ${widget.batType}',style: TextStyle(color:Colors.white70)),
          ],
        )]
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
