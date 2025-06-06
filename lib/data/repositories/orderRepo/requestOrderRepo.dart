import 'package:manafea/domain/models/baseOrderModel/baseOrderModel.dart';

import '../../../domain/models/hotelModels/requestHotelBooking.dart';
 import '../../services/orderServices/requestOrderService.dart';

class RequestOrderRepo {
  RequestOrderService requestOrderService;

  RequestOrderRepo(this.requestOrderService);

  Future<void> requestOrder({required BaseOrder requestOrder}) async {
    try {
      await requestOrderService.uploadOrder(
           model : requestOrder);
    } catch (e) {
      print("Error in RequestOrderRepo: ${e.toString()}");
      throw Exception("Failed to send order: ${e.toString()}");
    }
  }
}
