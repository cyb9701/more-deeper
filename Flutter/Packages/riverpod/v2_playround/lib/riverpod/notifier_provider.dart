import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/model/shopping_item_model.dart';

final shoppingListProvider =
    NotifierProvider<ShoppginListNotifier, List<ShoppingItemModel>>(ShoppginListNotifier.new);

class ShoppginListNotifier extends Notifier<List<ShoppingItemModel>> {
  @override
  build() {
    return [
      ShoppingItemModel(
        name: '김치',
        quantity: 3,
        hasBought: false,
        isSpicy: true,
      ),
      ShoppingItemModel(
        name: '라면',
        quantity: 5,
        hasBought: false,
        isSpicy: true,
      ),
      ShoppingItemModel(
        name: '삼겹살',
        quantity: 15,
        hasBought: false,
        isSpicy: false,
      ),
      ShoppingItemModel(
        name: '수박',
        quantity: 1,
        hasBought: true,
        isSpicy: false,
      ),
    ];
  }

  void toggleHasBought({required String name}) {
    state = state
        .map(
          (e) => e.name == name
              ? ShoppingItemModel(
                  name: e.name,
                  quantity: e.quantity,
                  hasBought: !e.hasBought,
                  isSpicy: e.isSpicy,
                )
              : e,
        )
        .toList();
  }
}
