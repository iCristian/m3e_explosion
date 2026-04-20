part of '../main.dart';

// Responsibility: Navigation and menu structure screens.

class _NavigationScreen extends StatelessWidget {
  const _NavigationScreen();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'Navigation M3E', actions: [_appBarBrandIcon()]),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBlast(
              title: l10n.navScreenTitle,
              subtitle: l10n.navScreenSubtitle,
              icon: Icons.alt_route,
            ),
            const SizedBox(height: 16),
            Text(l10n.navBarTitle, style: Theme.of(context).textTheme.titleLarge),
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
                destinations: [
                  NavigationDestinationM3E(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: l10n.navHomeLabel),
                  NavigationDestinationM3E(icon: const Icon(Icons.search_outlined), selectedIcon: const Icon(Icons.search), label: l10n.navSearchLabel),
                  NavigationDestinationM3E(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: l10n.navProfileLabel),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(l10n.navRailTitle, style: Theme.of(context).textTheme.titleLarge),
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
                      sections: [
                        NavigationRailM3ESection(
                          destinations: [
                            NavigationRailM3EDestination(icon: const Icon(Icons.dashboard_outlined), selectedIcon: const Icon(Icons.dashboard), label: l10n.navDashboardLabel),
                            NavigationRailM3EDestination(icon: const Icon(Icons.explore_outlined), selectedIcon: const Icon(Icons.explore), label: l10n.navExploreLabel),
                            NavigationRailM3EDestination(icon: const Icon(Icons.settings_outlined), selectedIcon: const Icon(Icons.settings), label: l10n.navSettingsLabel),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          l10n.navExampleContent,
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

