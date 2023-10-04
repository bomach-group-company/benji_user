import 'package:get/get.dart';

class LatLngDetailController extends GetxController {
  var latLngDetail = [].obs;
  setLatLngdetail(List latLngDetailList) {
    for (var i in latLngDetailList) {
      latLngDetail.add(i ?? '');
    }
  }
}
