//

import 'package:video_overlay_app/core/components/utils/package_export.dart';

printData(identifier, data) {
  if (kDebugMode) {
    return log('===> $identifier <=== $data');
  }
}
