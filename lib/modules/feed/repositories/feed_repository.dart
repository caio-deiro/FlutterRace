import 'package:meu_app/shared/models/order_model.dart';

abstract class IFeedRepository {
  Future<List<OrderModel>> getAll();
}
