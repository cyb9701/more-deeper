import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/model/shopping_item_model.dart';
import 'package:riverpod_playround/riverpod/state_notifier_provider.dart';

enum FilterState {
  notSpicy,
  spicy,
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>((ref) {
  // provider 안에서 ref를 사용할 경우, 웬만하면 watch를 사용하는 것을 권장한다.
  final filterState = ref.watch(filterProvider);
  final shoppingListState = ref.watch(shoppingListProvider);

  if (filterState == FilterState.all) {
    return shoppingListState;
  } else {
    return shoppingListState
        .where((e) => filterState == FilterState.spicy ? e.isSpicy : !e.isSpicy)
        .toList();
  }
});
