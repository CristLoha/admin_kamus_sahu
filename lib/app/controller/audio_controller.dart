import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  AudioController() {
    _audioPlayer = AudioPlayer();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  Future<void> togglePlaying(String audioUrl) async {
    if (isPlaying) {
      await _audioPlayer.pause();
      isPlaying = false;
    }
    await _audioPlayer.setUrl(audioUrl);
    await _audioPlayer.play();
    isPlaying = true;
  }
}
