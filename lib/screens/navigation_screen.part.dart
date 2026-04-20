part of '../main.dart';

// Responsibility: Navigation and menu structure screens.

class _NavigationScreen extends StatelessWidget {
  const _NavigationScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Navigation M3E', actions: [_appBarBrandIcon()]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroBlast(
              title: 'Navigation Experiments',
              subtitle: 'Destinos, rail y comportamiento expresivo de layout.',
              icon: Icons.alt_route,
            ),
            const SizedBox(height: 16),
            Text('NavigationBarM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: NavigationBarM3E(
                selectedIndex: 1,
                onDestinationSelected: (_) {},
                destinations: const [
                  NavigationDestinationM3E(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestinationM3E(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Search'),
                  NavigationDestinationM3E(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('NavigationRailM3E', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surfaceContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    NavigationRailM3E(
                      selectedIndex: 0,
                      onDestinationSelected: (_) {},
                      sections: const [
                        NavigationRailM3ESection(
                          destinations: [
                            NavigationRailM3EDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
                            NavigationRailM3EDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
                            NavigationRailM3EDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Contenido de ejemplo',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

