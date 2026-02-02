import 'dart:async';

import 'package:artists_alley_dashboard/src/utils/watchers/watchers.dart';
import 'package:get/get.dart';

class MaintenanceWatcher extends GetxService {
  static MaintenanceWatcher get to => Get.find<MaintenanceWatcher>();

  final _isInMaintenance = false.obs;
  StreamSubscription? _subscription;

  bool get isInMaintenance => _isInMaintenance.value;
  set isInMaintenance(bool value) => _isInMaintenance.value = value;

  void updateMaintenanceStatus(bool status) => _isInMaintenance.value = status;

  void _initListener() {
    updateMaintenanceStatus(false);
  }

  void checkStatus() async =>
      _isInMaintenance.value = await MaintenanceStatusHelper.checkStatus();

  @override
  void onInit() {
    checkStatus();
    _initListener();
    super.onInit();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
