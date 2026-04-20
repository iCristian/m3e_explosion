part of '../main.dart';

// Responsibility: Core material and basic Flutter widget screens.

class _CoreWidgetsScreen extends StatefulWidget {
  const _CoreWidgetsScreen();

  @override
  State<_CoreWidgetsScreen> createState() => _CoreWidgetsScreenState();
}

class _CoreWidgetsScreenState extends State<_CoreWidgetsScreen> {
  final List<String> _demoItems = ['Alpha', 'Beta', 'Gamma', 'Delta'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'm3e_core gallery', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _HeroBlast(
            title: l10n.coreWidgetsTitle,
            subtitle: l10n.coreWidgetsSubtitle,
            icon: Icons.widgets,
          ),
          const SizedBox(height: 16),
          Text(l10n.coreCardColumnTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3ECardColumn(
            children: [
              ListTile(leading: const Icon(Icons.palette), title: Text(l10n.coreCardItem1)),
              ListTile(leading: const Icon(Icons.layers), title: Text(l10n.coreCardItem2)),
              ListTile(leading: const Icon(Icons.bolt), title: Text(l10n.coreCardItem3)),
            ],
          ),
          const SizedBox(height: 24),
          Text(l10n.coreDismissibleTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDismissibleCardColumn(
            itemCount: _demoItems.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('Dismissible ${_demoItems[index]}'),
              subtitle: Text(l10n.coreDismissibleSlideHint),
            ),
            onDismiss: (index, direction) async => true,
          ),
          const SizedBox(height: 24),
          Text(l10n.coreExpandableTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EExpandableCardColumn(
            itemCount: 3,
            headerBuilder: (context, index, isExpanded) => Row(
              children: [
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                const SizedBox(width: 8),
                Text('${l10n.coreSectionN}${index + 1}'),
              ],
            ),
            bodyBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('${l10n.coreSectionContent}${index + 1}.'),
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.coreDropdownTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDropdownMenu<String>(
            singleSelect: true,
            searchEnabled: true,
            items: [
              m3ec.M3EDropdownItem(label: l10n.coreDropdownBlue, value: 'blue'),
              m3ec.M3EDropdownItem(label: l10n.coreDropdownGreen, value: 'green'),
              m3ec.M3EDropdownItem(label: l10n.coreDropdownAmber, value: 'amber'),
            ],
            onSelectionChanged: (items) {},
          ),
        ],
      ),
    );
  }
}

