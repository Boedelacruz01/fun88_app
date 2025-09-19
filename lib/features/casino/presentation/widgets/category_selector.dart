import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String selected;
  final Function(String) onSelect;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Split Search and others
    final searchCategory = categories.firstWhere((c) => c['label'] == 'Search');
    final otherCategories = categories
        .where((c) => c['label'] != 'Search')
        .toList();

    return SizedBox(
      height: 80, // fixed height for consistency
      child: Row(
        children: [
          // 🔹 Pinned Search button (aligned)
          SizedBox(
            width: 70,
            child: InkWell(
              onTap: () => onSelect(searchCategory['label']),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // align center
                children: [
                  Icon(
                    searchCategory['icon'],
                    color: selected == searchCategory['label']
                        ? Colors.blue
                        : Colors.grey,
                    size: 28,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    searchCategory['label'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected == searchCategory['label']
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: selected == searchCategory['label']
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Scrollable other categories (aligned the same way)
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: otherCategories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = otherCategories[index];
                final isSelected = selected == cat['label'];

                return SizedBox(
                  width: 70,
                  child: InkWell(
                    onTap: () => onSelect(cat['label']),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // align center
                      children: [
                        Icon(
                          cat['icon'],
                          color: isSelected ? Colors.blue : Colors.grey,
                          size: 28,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cat['label'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
