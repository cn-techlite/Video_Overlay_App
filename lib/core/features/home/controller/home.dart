import 'dart:async';
import 'package:video_overlay_app/core/components/utils/package_export.dart';
import 'package:video_overlay_app/core/features/home/view/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenController();
}

class HomeScreenController extends State<HomeScreen> {
  late VideoPlayerController videoController;
  bool showControls = false;
  bool initialized = false;
  Timer? _hideTimer;
  @override
  void initState() {
    super.initState();

    // Use a web-friendly video (MP4 over HTTPS)
    videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              // "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
            ),
          )
          ..initialize().then((_) {
            videoController.setLooping(true);

            // ✅ Web autoplay fix
            if (kIsWeb) {
              // Web browsers block autoplay unless muted
              videoController.setVolume(1);
              videoController.play();
            } else {
              // On mobile, play with sound
              videoController.setVolume(1);
              videoController.play();
            }

            setState(() => initialized = true);
          });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    videoController.dispose();
    super.dispose();
  }

  void toggleControlsVisibility() {
    setState(() {
      showControls = !showControls;
    });
    if (showControls) resetControlsTimer();
  }

  void resetControlsTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => showControls = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenView(this);
  }
}
