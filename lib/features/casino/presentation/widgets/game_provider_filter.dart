import 'package:flutter/material.dart';

class GameProviderFilter extends StatefulWidget {
  final List<String> providers; // just image paths
  final void Function(List<String>) onApply;

  const GameProviderFilter({
    super.key,
    required this.providers,
    required this.onApply,
  });

  @override
  State<GameProviderFilter> createState() => _GameProviderFilterState();
}

class _GameProviderFilterState extends State<GameProviderFilter> {
  final Set<String> _selected = {};

  void _toggleSelection(String provider) {
    setState(() {
      if (_selected.contains(provider)) {
        _selected.remove(provider);
      } else {
        _selected.add(provider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.filter_list, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      "Game Provider (${widget.providers.length})",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Providers grid (images only)
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5, // wider space for logos
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: widget.providers.length,
                  itemBuilder: (context, index) {
                    final provider = widget.providers[index];
                    final isSelected = _selected.contains(provider);

                    return InkWell(
                      onTap: () => _toggleSelection(provider),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              provider,
                              fit: BoxFit.contain,
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Apply button
              Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    widget.onApply(_selected.toList());
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
