import 'dart:async';
import 'package:video_overlay_app/core/components/utils/colors.dart';
import 'package:video_overlay_app/core/components/utils/package_export.dart';
import 'package:video_overlay_app/core/components/utils/size_config.dart';
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

  String overlayText = "Welcome to InfiniteSimul";
  Color overlayColor = AppColors.white;
  double fontSize = 25.textSize;

  @override
  void initState() {
    super.initState();

    // Use a web-friendly video (MP4 over HTTPS)
    videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
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

  // Toggle controls for visibility of the controls
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

  void openSettings() {
    TextEditingController textController = TextEditingController(
      text: overlayText,
    );
    double tempFontSize = fontSize;
    Color tempColor = overlayColor;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: double.infinity, // Ensure no max width constraint
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Wrap(
                  runSpacing: 20,
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Customize Overlay",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Text Field
                    TextField(
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Overlay Text",
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Font size slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Font Size",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Slider(
                          min: 16,
                          max: 80,
                          divisions: 8,
                          value: tempFontSize,
                          label: tempFontSize.round().toString(),
                          activeColor: Colors.white,
                          onChanged: (val) =>
                              setModalState(() => tempFontSize = val.textSize),
                        ),
                      ],
                    ),

                    // Color selection
                    Wrap(
                      spacing: 10,
                      children: [
                        for (final color in [
                          Colors.white,
                          Colors.yellow,
                          Colors.orange,
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                        ])
                          GestureDetector(
                            onTap: () => setModalState(() => tempColor = color),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: color,
                              child: tempColor == color
                                  ? const Icon(Icons.check, color: Colors.black)
                                  : null,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Save button
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          overlayText = textController.text.trim().isEmpty
                              ? overlayText
                              : textController.text;
                          fontSize = tempFontSize;
                          overlayColor = tempColor;
                        });
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenView(this);
  }
}
