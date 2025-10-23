import 'package:video_overlay_app/core/components/architecture/mvc.dart';
import 'package:video_overlay_app/core/components/utils/colors.dart';
import 'package:video_overlay_app/core/components/utils/package_export.dart';
import 'package:video_overlay_app/core/components/utils/size_config.dart';
import 'package:video_overlay_app/core/features/home/controller/home.dart';

class HomeScreenView extends StatelessView<HomeScreen, HomeScreenController> {
  const HomeScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3D7BF9), Color(0xFF80D0C7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape =
              MediaQuery.of(context).orientation == Orientation.landscape;

          // 🔹 Keep landscape ratio but adjust based on actual orientation
          final double videoWidth = isLandscape
              ? constraints.maxWidth *
                    0.8 // take 80% of width in landscape
              : constraints.maxWidth * 0.9; // take 90% of width in portrait

          final double videoHeight = isLandscape
              ? videoWidth *
                    (9 / 16) // normal landscape ratio
              : videoWidth * (9 / 16); // keep same ratio for portrait

          return Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: controller.toggleControlsVisibility,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// 🎥 Video Container (Landscape Ratio)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: videoWidth,
                    height: videoHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: controller.videoController.value.isInitialized
                        ? Stack(
                            children: [
                              FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: controller
                                      .videoController
                                      .value
                                      .size
                                      .width,
                                  height: controller
                                      .videoController
                                      .value
                                      .size
                                      .height,
                                  child: VideoPlayer(
                                    controller.videoController,
                                  ),
                                ),
                              ),

                              /// ▶️ Play/Pause button

                              /// 📊 Progress indicator (bottom overlay)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: AnimatedOpacity(
                                  opacity: controller.showControls ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: VideoProgressIndicator(
                                    controller.videoController,
                                    allowScrubbing: true,
                                    padding: const EdgeInsets.all(8),
                                    colors: VideoProgressColors(
                                      playedColor: Colors.blueAccent,
                                      bufferedColor: Colors.white54,
                                      backgroundColor: Colors.white24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),

                  /// 📝 Overlay Text
                  Positioned(
                    bottom: isLandscape
                        ? videoHeight * 0.08
                        : videoHeight * 0.12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Welcome to InfiniteSimul',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.textSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
