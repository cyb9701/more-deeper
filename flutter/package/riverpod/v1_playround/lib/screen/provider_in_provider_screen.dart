import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/provider_in_provider.dart';

import '../riverpod/state_notifier_provider.dart';

class ProviderInProviderScreen extends ConsumerWidget {
  const ProviderInProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterdShoppingListState = ref.watch(filteredShoppingListProvider);
    final filterState = ref.watch(filterProvider);

    return DefaultLayout(
      title: 'Provider In Provider',
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (context) => FilterState.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                  ),
                ),
              )
              .toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(filterState.name),
            ),
          ),
        ),
      ],
      body: ListView(
        children: filterdShoppingListState
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                value: e.hasBought,
                onChanged: (value) {
                  ref.read(shoppingListProvider.notifier).toggleHasBought(name: e.name);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
