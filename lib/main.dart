import 'package:video_overlay_app/core/components/utils/colors.dart';
import 'package:video_overlay_app/core/components/utils/package_export.dart';
import 'package:video_overlay_app/core/components/utils/size_config.dart';
import 'package:video_overlay_app/core/features/home/controller/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // if (SizeConfig.deviceType == DeviceType.tv) {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ]);
    // } else {
    //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // }
    return MaterialApp(
      title: 'Video Overlay App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: const HomeScreen(),
    );
  }
}
