import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/games_provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _index = 3; // Default to "Casino Live"

  @override
  Widget build(BuildContext context) {
    const selectedColor = Colors.blue;
    const unselectedColor = Colors.grey;

    TextStyle labelStyle(bool isSelected) => TextStyle(
      fontSize: 12,
      color: isSelected ? selectedColor : unselectedColor,
    );

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      showUnselectedLabels: true,
      currentIndex: _index,
      onTap: (i) {
        setState(() => _index = i);

        final gamesProvider = context.read<GamesProvider>();

        switch (i) {
          case 0:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sports tapped (placeholder)')),
            );
            break;
          case 1:
            gamesProvider.loadGames("Favorites");
            break;
          case 2:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invite tapped (placeholder)')),
            );
            break;
          case 3:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Casino Live tapped (placeholder)')),
            );
            gamesProvider.loadGames("Live");
            break;
          case 4:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cashier tapped (placeholder)')),
            );
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports_soccer),
              const SizedBox(height: 4),
              Text("Sports", style: labelStyle(_index == 0)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star_border),
              const SizedBox(height: 4),
              Text("Favorites", style: labelStyle(_index == 1)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_add),
              const SizedBox(height: 4),
              Text("Invite", style: labelStyle(_index == 2)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.casino),
              const SizedBox(height: 4),
              Text("Casino Live", style: labelStyle(_index == 3)),
            ],
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_balance_wallet),
              const SizedBox(height: 4),
              Text("Cashier", style: labelStyle(_index == 4)),
            ],
          ),
          label: "",
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/games_provider.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _index = 3; // Default to "Casino Live"

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.blue,
//       unselectedItemColor: Colors.grey,
//       showUnselectedLabels: true,
//       currentIndex: _index,
//       onTap: (i) {
//         setState(() => _index = i);

//         final gamesProvider = context.read<GamesProvider>();

//         switch (i) {
//           case 0:
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Sports tapped (placeholder)')),
//             );
//             break;
//           case 1:
//             // 🔹 Load favorites
//             gamesProvider.loadGames("Favorites");
//             break;
//           case 2:
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Invite tapped (placeholder)')),
//             );
//             break;
//           case 3:
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Casino Live tapped (placeholder)')),
//             );
//             gamesProvider.loadGames("Live");
//             break;
//           case 4:
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Cashier tapped (placeholder)')),
//             );
//             break;
//         }
//       },
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.sports_soccer),
//           label: 'Sports',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.star_border),
//           label: 'Favorites',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Invite'),
//         BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Casino Live'),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_balance_wallet),
//           label: 'Cashier',
//         ),
//       ],
//     );
//   }
// }
