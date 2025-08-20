import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  const AudioPlayerWidget({super.key, required this.url});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onDurationChanged.listen((d) {
      setState(() => duration = d);
    });
    _player.onPositionChanged.listen((p) {
      setState(() => position = p);
    });
    _player.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider(
        //   activeColor: Colors.yellow,
        //   value: position.inSeconds.toDouble(),
        //   max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1,
        //   onChanged: (value) async {
        //     final newPos = Duration(seconds: value.toInt());
        //     await _player.seek(newPos);
        //   },
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              onPressed: () async {
                if (isPlaying) {
                  await _player.pause();
                } else {
                  await _player.play(UrlSource(widget.url));
                }
                setState(() => isPlaying = !isPlaying);
              },
            ),
            Text(
              "${_formatTime(position)} / ${_formatTime(duration)}",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
