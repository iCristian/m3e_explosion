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
    return Scaffold(
      appBar: _buildAnimatedHeader(context, titleText: 'm3e_core gallery', actions: [_appBarBrandIcon()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _HeroBlast(
            title: 'Core Widgets Studio',
            subtitle: 'Cards, dismiss, expand y dropdown para UX compleja.',
            icon: Icons.widgets,
          ),
          const SizedBox(height: 16),
          Text('M3ECardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3ECardColumn(
            children: const [
              ListTile(leading: Icon(Icons.palette), title: Text('Card item 1')),
              ListTile(leading: Icon(Icons.layers), title: Text('Card item 2')),
              ListTile(leading: Icon(Icons.bolt), title: Text('Card item 3')),
            ],
          ),
          const SizedBox(height: 24),
          Text('M3EDismissibleCardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDismissibleCardColumn(
            itemCount: _demoItems.length,
            itemBuilder: (context, index) => ListTile(
              title: Text('Dismissible ${_demoItems[index]}'),
              subtitle: const Text('Desliza a un lado para probar'),
            ),
            onDismiss: (index, direction) async => true,
          ),
          const SizedBox(height: 24),
          Text('M3EExpandableCardColumn', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EExpandableCardColumn(
            itemCount: 3,
            headerBuilder: (context, index, isExpanded) => Row(
              children: [
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                const SizedBox(width: 8),
                Text('Seccion #${index + 1}'),
              ],
            ),
            bodyBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Contenido extendido de la seccion #${index + 1}.'),
            ),
          ),
          const SizedBox(height: 24),
          Text('M3EDropdownMenu', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          m3ec.M3EDropdownMenu<String>(
            singleSelect: true,
            searchEnabled: true,
            items: const [
              m3ec.M3EDropdownItem(label: 'Expressive Blue', value: 'blue'),
              m3ec.M3EDropdownItem(label: 'Expressive Green', value: 'green'),
              m3ec.M3EDropdownItem(label: 'Expressive Amber', value: 'amber'),
            ],
            onSelectionChanged: (items) {},
          ),
        ],
      ),
    );
  }
}

