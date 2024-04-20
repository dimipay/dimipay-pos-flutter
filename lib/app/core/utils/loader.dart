import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:dimipay_kiosk/app/services/transaction/service.dart';
import 'package:dimipay_kiosk/app/services/face_sign/service.dart';
import 'package:dimipay_kiosk/app/services/product/service.dart';
import 'package:dimipay_kiosk/app/services/health/service.dart';
import 'package:dimipay_kiosk/app/services/auth/service.dart';
import 'package:dimipay_kiosk/app/widgets/alert_modal.dart';
import 'package:dimipay_kiosk/app/provider/api_interface.dart';
import 'package:dimipay_kiosk/app/provider/api.dart';

class AppLoader {
  Future<void> load() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // await dotenv.load(fileName: "env/.env", isOptional: true);

    Get.lazyPut(() => AlertModal());
    Get.lazyPut(() => HealthService());
    Get.lazyPut(() => ProductService());
    Get.lazyPut(() => TransactionService());
    Get.lazyPut<ApiProvider>(() => DevApiProvider());

    await Get.putAsync(() => FaceSignService().init());
    await Get.putAsync(() => AuthService().init());
  }
}
