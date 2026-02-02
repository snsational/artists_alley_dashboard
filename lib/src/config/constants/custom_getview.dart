import 'package:get/get.dart';

abstract class CustomGetView<Controller, Presenter>
    extends GetView<Controller> {
  const CustomGetView({super.key});

  Presenter get presenter => GetInstance().find<Presenter>(tag: tag);
}
