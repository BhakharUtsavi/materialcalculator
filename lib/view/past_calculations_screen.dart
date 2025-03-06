import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:materialcalculator/controller/inventory_provider.dart';

class PastCalculationsScreen extends StatelessWidget {
  const PastCalculationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<InventoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Used Inventory History")),
      body: inventory.usedItems.isEmpty
          ? const Center(child: Text("No history available."))
          : ListView.builder(
        itemCount: inventory.usedItems.length,
        itemBuilder: (context, index) {
          var usedItem = inventory.usedItems[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              title: Text("${usedItem['name']} - ${usedItem['quantity']} ${usedItem['unit']}"),
              subtitle: Text("Used on: ${usedItem['timestamp']}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Delete the used item
                  inventory.deleteUsedItem(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
