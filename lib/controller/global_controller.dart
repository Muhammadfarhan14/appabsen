import 'package:get/get.dart';
import 'package:flutter_application_1/utils/shared_preference_utils.dart';
import 'package:flutter_application_1/utils/constants.dart';

class GlobalController extends GetxController {
  Rx<String?> token = Rx<String?>(null);
  Rx<int?> id = Rx<int?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadToken(); // Memuat token saat inisialisasi controller
  }

  // Metode untuk memuat token
  Future<void> _loadToken() async {
    String? storedToken = await SharedPreferenceUtils.getString(KEY_TOKEN);
    int? storedId = await SharedPreferenceUtils.getInt(KEY_ID);
    token.value = storedToken;
    id.value = storedId;
  }
}
