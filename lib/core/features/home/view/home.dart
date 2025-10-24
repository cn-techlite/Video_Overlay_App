import 'package:video_overlay_app/core/components/architecture/mvc.dart';
import 'package:video_overlay_app/core/components/utils/colors.dart';
import 'package:video_overlay_app/core/components/utils/package_export.dart';
import 'package:video_overlay_app/core/components/utils/size_config.dart';
import 'package:video_overlay_app/core/features/home/controller/home.dart';

class HomeScreenView extends StatelessView<HomeScreen, HomeScreenController> {
  const HomeScreenView(super.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;

          // 🧭 Hide system bars only in landscape
          if (isLandscape) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          } else {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          }

          /// Calculate video size (centered)
          final double videoWidth = isLandscape
              ? screenWidth * 0.8
              : screenWidth * 0.9;
          final double videoHeight = videoWidth * (9 / 16);

          return Center(
            child: controller.videoController.value.isInitialized
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: controller.toggleControlsVisibility,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// 🎥 Video Container (always centered)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: videoWidth,
                          height: videoHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              isLandscape ? 8 : 16,
                            ),
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                            child: SizedBox(
                              width:
                                  controller.videoController.value.size.width,
                              height:
                                  controller.videoController.value.size.height,
                              child: VideoPlayer(controller.videoController),
                            ),
                          ),
                        ),

                        /// 📝 Overlay Text
                        Positioned(
                          top: isLandscape ? 145 : 70,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.bodyGrey.withValues(
                                  alpha: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Welcome to InfiniteSimul',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.textSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// ▶️ Play / Pause button
                        if (controller.showControls)
                          GestureDetector(
                            //  onTap: controller.togglePlayPause,
                            child: AnimatedOpacity(
                              opacity: controller.showControls ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                controller.videoController.value.isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                size: isLandscape ? 70 : 90,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),

                        /// 📊 Progress Indicator
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
                              colors: const VideoProgressColors(
                                playedColor: Colors.blueAccent,
                                bufferedColor: Colors.white54,
                                backgroundColor: Colors.white24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
