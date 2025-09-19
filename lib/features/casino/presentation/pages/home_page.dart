// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../providers/games_provider.dart';
import '../widgets/game_provider_filter.dart';
import '../widgets/top_carousel.dart';
import '../widgets/category_selector.dart';
import '../widgets/game_card.dart';
import '../widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    final gamesProvider = context.read<GamesProvider>();
    _searchController = TextEditingController(text: gamesProvider.searchQuery);
    _searchFocusNode = FocusNode();

    // Keep controller in sync with provider
    _searchController.addListener(() {
      if (_searchController.text != gamesProvider.searchQuery) {
        gamesProvider.setSearchQuery(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final gamesProvider = context.watch<GamesProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menu tapped (placeholder)')),
                );
              },
            ),
            const Text(
              'FUN88',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: const [
                Icon(
                  Icons.account_balance_wallet,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  '\$1,990.6',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile tapped (placeholder)')),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmallHeight = constraints.maxHeight < 400;
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;

            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopCarousel(),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, color: Colors.orange),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '¡FELICIDADES artxxxxipa! GANADOR DESTACADO',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),

                CategorySelector(
                  categories: categoryProvider.categories,
                  selected: categoryProvider.selected,
                  onSelect: (c) async {
                    context.read<CategoryProvider>().select(c);
                    if (c == 'Search') {
                      await context.read<GamesProvider>().prepareForSearch();

                      // 🔹 Auto-focus search bar when entering search mode
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _searchFocusNode.requestFocus();
                      });
                    } else {
                      context.read<GamesProvider>().loadGames(c);
                      _searchFocusNode.unfocus(); // close keyboard
                    }
                  },
                ),

                if (categoryProvider.searchMode)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 8,
                      bottom: MediaQuery.of(context).viewInsets.bottom > 0
                          ? 80
                          : 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                hintText: 'Search games',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: gamesProvider.searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          _searchController.clear();
                                          context
                                              .read<GamesProvider>()
                                              .clearSearch();
                                          FocusScope.of(context).unfocus();
                                        },
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.manage_search_rounded,
                            color: Colors.blue,
                            size: 32,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return GameProviderFilter(
                                  providers: [
                                    "assets/game_provider_images/EM.webp",
                                    "assets/game_provider_images/EVO.webp",
                                    "assets/game_provider_images/EXPANSE.webp",
                                    "assets/game_provider_images/EZG.webp",
                                    "assets/game_provider_images/GAMEART.webp",
                                    "assets/game_provider_images/HAB.webp",
                                    "assets/game_provider_images/HACKSAW.webp",
                                    "assets/game_provider_images/INBET.webp",
                                    "assets/game_provider_images/MPLAY.webp",
                                    "assets/game_provider_images/NETENT.webp",
                                    "assets/game_provider_images/PGSOFT.webp",
                                    "assets/game_provider_images/PNG.webp",
                                    "assets/game_provider_images/PP.webp",
                                    "assets/game_provider_images/PRAGMATICPLAY.webp",
                                    "assets/game_provider_images/PS.webp",
                                    "assets/game_provider_images/PT.webp",
                                    "assets/game_provider_images/REDTIGER.webp",
                                    "assets/game_provider_images/RELAX.webp",
                                  ],
                                  onApply: (selectedProviders) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Selected: ${selectedProviders.length} providers",
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                if (!isSmallHeight)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: gamesProvider.loading
                          ? const Center(child: CircularProgressIndicator())
                          : gamesProvider.games.isEmpty
                          ? const Center(
                              child: Text(
                                "No games found",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : GridView.builder(
                              itemCount: gamesProvider.games.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: isLandscape ? 5 : 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.9,
                                  ),
                              itemBuilder: (context, index) {
                                final g = gamesProvider.games[index];
                                return GameCard(
                                  game: g,
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Tapped ${g.title}'),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ),
              ],
            );

            if (isSmallHeight) {
              return SingleChildScrollView(child: content);
            }

            return content;
          },
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/category_provider.dart';
// import '../providers/games_provider.dart';
// import '../widgets/game_provider_filter.dart';
// import '../widgets/top_carousel.dart';
// import '../widgets/category_selector.dart';
// import '../widgets/game_card.dart';
// import '../widgets/bottom_nav.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categoryProvider = context.watch<CategoryProvider>();
//     final gamesProvider = context.watch<GamesProvider>();

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.menu, color: Colors.blue),
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Menu tapped (placeholder)')),
//                 );
//               },
//             ),
//             const Text(
//               'FUN88',
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Spacer(),
//             Row(
//               children: const [
//                 Icon(
//                   Icons.account_balance_wallet,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//                 SizedBox(width: 4),
//                 Text(
//                   '\$1,990.6',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 16),
//             IconButton(
//               icon: const Icon(Icons.person, color: Colors.blue),
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Profile tapped (placeholder)')),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: Column(
//           children: [
//             const TopCarousel(),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   const Icon(Icons.notifications, color: Colors.yellow),
//                   const SizedBox(width: 6),
//                   Flexible(
//                     child: Text(
//                       '¡FELICIDADES artxxxxipa! GANADOR DESTACADO',
//                       style: const TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       softWrap: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Categories
//             CategorySelector(
//               categories: categoryProvider.categories,
//               selected: categoryProvider.selected,
//               onSelect: (c) async {
//                 context.read<CategoryProvider>().select(c);
//                 if (c == 'Search') {
//                   await context.read<GamesProvider>().prepareForSearch();
//                 } else {
//                   context.read<GamesProvider>().loadGames(c);
//                 }
//               },
//             ),

//             if (categoryProvider.searchMode)
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: 12,
//                   right: 12,
//                   top: 8,
//                   bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 80 : 8,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 45,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Search games',
//                             prefixIcon: const Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 12,
//                             ),
//                           ),
//                           onChanged: (query) {
//                             print('TextField onChanged: "$query"');
//                             context.read<GamesProvider>().setSearchQuery(query);
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.manage_search_rounded,
//                         color: Colors.blue,
//                         size: 35,
//                       ),
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) {
//                             return GameProviderFilter(
//                               providers: [
//                                 "assets/game_provider_images/EM.webp",
//                                 "assets/game_provider_images/EVO.webp",
//                                 "assets/game_provider_images/EXPANSE.webp",
//                                 "assets/game_provider_images/EZG.webp",
//                                 "assets/game_provider_images/GAMEART.webp",
//                                 "assets/game_provider_images/HAB.webp",
//                                 "assets/game_provider_images/HACKSAW.webp",
//                                 "assets/game_provider_images/INBET.webp",
//                                 "assets/game_provider_images/MPLAY.webp",
//                                 "assets/game_provider_images/NETENT.webp",
//                                 "assets/game_provider_images/PGSOFT.webp",
//                                 "assets/game_provider_images/PNG.webp",
//                                 "assets/game_provider_images/PP.webp",
//                                 "assets/game_provider_images/PRAGMATICPLAY.webp",
//                                 "assets/game_provider_images/PS.webp",
//                                 "assets/game_provider_images/PT.webp",
//                                 "assets/game_provider_images/REDTIGER.webp",
//                                 "assets/game_provider_images/RELAX.webp",
//                               ],
//                               onApply: (selectedProviders) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                       "Selected: ${selectedProviders.length} providers",
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//             // 🔹 Expandable Grid (scrollable independently)
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12,
//                   vertical: 8,
//                 ),
//                 child: gamesProvider.loading
//                     ? const Center(child: CircularProgressIndicator())
//                     : gamesProvider.games.isEmpty
//                     ? const Center(
//                         child: Text(
//                           "No games found",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       )
//                     : GridView.builder(
//                         itemCount: gamesProvider.games.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 4,
//                               mainAxisSpacing: 4,
//                               childAspectRatio: 0.9,
//                             ),
//                         itemBuilder: (context, index) {
//                           final g = gamesProvider.games[index];
//                           return GameCard(
//                             game: g,
//                             onTap: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Tapped ${g.title}')),
//                               );
//                             },
//                           );
//                         },
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const BottomNav(),
//     );
//   }
// }
