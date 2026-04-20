part of '../main.dart';

// Responsibility: Refresh indicators and AppBar customization screens.

class _RefreshAndAppBarScreen extends StatefulWidget {
  const _RefreshAndAppBarScreen();

  @override
  State<_RefreshAndAppBarScreen> createState() => _RefreshAndAppBarScreenState();
}

class _RefreshAndAppBarScreenState extends State<_RefreshAndAppBarScreen> {
  final List<int> _items = List<int>.generate(20, (i) => i + 1);
  bool _isRefreshing = false;
  int _refreshCount = 0;
  DateTime? _lastRefreshAt;

  Future<void> _onRefresh() async {
    if (_isRefreshing) {
      return;
    }
    setState(() => _isRefreshing = true);
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) {
      return;
    }
    setState(() {
      for (var i = 0; i < 3; i++) {
        _items.insert(0, _items.length + 1);
      }
      _refreshCount += 1;
      _lastRefreshAt = DateTime.now();
      _isRefreshing = false;
    });
  }

  Future<void> _resetAndRefresh() async {
    if (_isRefreshing) {
      return;
    }
    setState(() {
      _items
        ..clear()
        ..addAll(List<int>.generate(10, (i) => i + 1));
    });
    await _onRefresh();
  }

  String _formatLastRefresh() {
    final date = _lastRefreshAt;
    if (date == null) {
      return 'Sin refrescos aún';
    }
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    final s = date.second.toString().padLeft(2, '0');
    return 'Último refresh: $h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAnimatedHeader(
        context,
        titleText: 'expressive_refresh + app_bar_m3e',
        actions: [
          IconButtonM3E(icon: const Icon(Icons.replay), onPressed: _onRefresh),
          IconButtonM3E(icon: const Icon(Icons.cleaning_services_outlined), onPressed: _resetAndRefresh),
          _appBarBrandIcon(),
        ],
      ),
      body: ExpressiveRefreshIndicator.contained(
        onRefresh: _onRefresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _items.length + 1,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Laboratorio de Refresh', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text(
                        'Haz pull-to-refresh o usa los botones para forzar recarga y ver el comportamiento en vivo.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ButtonM3E(
                            label: Text(_isRefreshing ? 'Refrescando...' : 'Forzar refresh'),
                            onPressed: _isRefreshing ? null : _onRefresh,
                            style: ButtonM3EStyle.filled,
                          ),
                          ButtonM3E(
                            label: const Text('Reset + Refresh'),
                            onPressed: _isRefreshing ? null : _resetAndRefresh,
                            style: ButtonM3EStyle.tonal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: Text('Refresh ejecutados: $_refreshCount')),
                          if (_isRefreshing) const SizedBox(width: 24, height: 24, child: eli.ExpressiveLoadingIndicator()),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(_formatLastRefresh(), style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              );
            }
            final item = _items[index - 1];
            return Card(
              child: ListTile(
                leading: Icon(item.isEven ? Icons.widgets : Icons.auto_awesome),
                title: Text('Componente demostrativo #$item'),
                subtitle: const Text('Haz pull-to-refresh para insertar más elementos'),
              ),
            );
          },
        ),
      ),
    );
  }
}

