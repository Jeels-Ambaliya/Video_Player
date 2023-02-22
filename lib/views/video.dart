import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../utils/video_utils.dart';

class Video_Page extends StatefulWidget {
  final String song;
  const Video_Page({Key? key, required this.song}) : super(key: key);

  @override
  State<Video_Page> createState() => _Video_PageState();
}

class _Video_PageState extends State<Video_Page> with TickerProviderStateMixin {
  VideoPlayerController? myVideoController;
  AnimationController? myVideo;
  ChewieController? myController;

  @override
  void initState() {
    super.initState();

    myVideo = AnimationController(
      vsync: this,
      duration: const Duration(
        microseconds: 250,
      ),
    );

    myVideoController = VideoPlayerController.asset(videoPath + widget.song)
      ..initialize().then(
        (value) => setState(() {}),
      );

    myController = ChewieController(
      videoPlayerController: myVideoController!,
      autoPlay: false,
      aspectRatio: 4 / 2,
      additionalOptions: (context) => [
        OptionItem(
          onTap: () {},
          iconData: Icons.settings,
          title: "Settings",
        ),
        OptionItem(
          onTap: () {},
          iconData: Icons.person,
          title: "Profile",
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    myVideoController!.dispose();
    myVideo!.dispose();
    myController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Video Player",
          style: TextStyle(
            fontSize: 25,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: myVideoController!.value.aspectRatio,
          child: Chewie(
            controller: myController!,
          ),
        ),
      ),
    );
  }
}
