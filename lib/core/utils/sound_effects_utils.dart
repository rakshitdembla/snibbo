import 'package:audioplayers/audioplayers.dart';
import 'package:snibbo_app/service_locator.dart';

class SoundEffectsUtils {
  static void receivedMessage() async{
    await sl<AudioPlayer>().play(AssetSource("received.mp3"));
  }

  static void sentMessage() async{
    await sl<AudioPlayer>().play(AssetSource("sent.mp3"));
  }
}