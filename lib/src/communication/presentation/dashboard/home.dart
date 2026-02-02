import 'dart:developer';

import 'package:artists_alley_dashboard/src/presentation/presentation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeViewPresentation extends HomeViewPresenter
    with GetSingleTickerProviderStateMixin {
  HomeViewPresentation() {
    _initPresenter();
  }

  final RxDouble _totalSales = 0.0.obs;
  @override
  double get totalSales => _totalSales.value;
  @override
  set totalSales(double value) => _totalSales.value = value;

  final RxInt _totalOrders = 0.obs;
  @override
  int get totalOrders => _totalOrders.value;
  @override
  set totalOrders(int value) => _totalOrders.value = value;

  Future<void> _initPresenter() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      _totalSales.value = 0;
      _totalOrders.value = 0;
      return;
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('orders')
        .get();

    var sum = 0.0;
    for (final doc in snapshot.docs) {
      _totalOrders.value++;
      final rawTotal = doc.data()['total'];
      if (rawTotal is num) {
        sum += rawTotal.toDouble();
      } else if (rawTotal is String) {
        final parsed = double.tryParse(rawTotal);
        if (parsed != null) {
          sum += parsed;
        }
      }
    }

    _totalSales.value = sum;
    update();

    log("Total sales calculated: $totalSales");
  }
}
