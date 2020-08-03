import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'home/home.dart';
void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = AudioCache();
    //AudioPlayer advancedPlayer = AudioPlayer();
    //String localFilePath;
    return Scaffold(
        appBar: AppBar(
          title: Text("Media Player",
          style: GoogleFonts.mcLaren(textStyle: TextStyle(fontWeight: FontWeight.w400))),
          backgroundColor: Color(0xff222831),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SamplePlayer()),);
              }, 
              textColor: Colors.white, 
              child: Text('Video', 
              style: GoogleFonts.mcLaren(textStyle: TextStyle(fontWeight: FontWeight.w600))),
            ),
            FlatButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoApp()),);
              }, 
              textColor: Colors.white, 
              child: Text('VideoPlay', 
              style: GoogleFonts.mcLaren(textStyle: TextStyle(fontWeight: FontWeight.w600))),
            ),
          ],
        ),
        body: Container(
          color: Color(0xff222831),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  color: Color(0xff393e46),
                  elevation: 20,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("Local Asset 3Peg", style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                          color: Colors.white
                        )
                      ),
                      SizedBox(height: 5.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.play_circle_outline),
                            color: Colors.white,
                            iconSize: 35, 
                            onPressed: () {
                              audioCache.play('audio/3Peg.mp3');
                            } 
                          ),
                          IconButton(
                            icon: Icon(Icons.pause_circle_outline),
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () => audioCache.clear('audio/3Peg.mp3')
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  color: Color(0xff393e46),
                  elevation: 20,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text('Ambient_c_motion',
                      style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            color: Colors.white, 
                            iconSize: 35,
                            onPressed: ()async{
                               await audioPlayer.play('https://luan.xyz/files/audio/ambient_c_motion.mp3');
                            }),
                          IconButton(
                            icon: Icon(Icons.pause), 
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () async{
                              await audioPlayer.pause();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.stop), 
                            color: Colors.white,
                            iconSize: 35,
                            onPressed: () async{
                              await audioPlayer.stop();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class SamplePlayer extends StatefulWidget {
  SamplePlayer({Key key}) : super(key: key);

  @override
  VideoPlayer createState() => VideoPlayer();
}

class VideoPlayer extends State<SamplePlayer> {
  FlickManager flickManager;
  @override
  void initState(){
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network("http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff222831),
          title: Text('Media Player'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              textColor: Colors.white, 
              child: Text('Audio', 
              style: GoogleFonts.mcLaren(textStyle: TextStyle(fontWeight: FontWeight.w600))), 
            )
          ],
        ),
        body: Container(
          child: FlickVideoPlayer(
            flickManager: flickManager),
        ),
      );
  }
}




