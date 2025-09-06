import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';
import 'notification_settings_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _weightUnit = 'kg';
  String _distanceUnit = 'km';

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        children: [
          // Notificações
          _buildSection(
            'Notificações',
            [
              _buildSwitchTile(
                'Lembretes de treino',
                'Receba notificações para treinar',
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
              ),
              _buildSwitchTile(
                'Lembretes de peso',
                'Receba lembretes para registrar seu peso',
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Aparência
          _buildSection(
            'Aparência',
            [
              _buildThemeTile(
                'Modo escuro',
                'Escolher tema do aplicativo',
                themeMode,
                (value) => ref.read(themeModeProvider.notifier).setThemeMode(value),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Notificações
          _buildSection(
            'Notificações',
            [
              _buildActionTile(
                'Configurar notificações',
                'Gerenciar lembretes e notificações',
                Icons.notifications,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Unidades
          _buildSection(
            'Unidades',
            [
              _buildDropdownTile(
                'Unidade de peso',
                'Unidade usada para peso corporal e exercícios',
                _weightUnit,
                ['kg', 'lbs'],
                (value) => setState(() => _weightUnit = value!),
              ),
              _buildDropdownTile(
                'Unidade de distância',
                'Unidade usada para exercícios aeróbicos',
                _distanceUnit,
                ['km', 'mi'],
                (value) => setState(() => _distanceUnit = value!),
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Dados
          _buildSection(
            'Dados',
            [
              _buildActionTile(
                'Exportar dados',
                'Baixar seus dados em PDF ou CSV',
                Icons.download,
                () {
                  // TODO: Implementar export
                },
              ),
              _buildActionTile(
                'Limpar dados',
                'Remover todos os dados do app',
                Icons.delete_forever,
                () => _showClearDataDialog(),
                isDestructive: true,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.largePadding),
          
          // Sobre
          _buildSection(
            'Sobre',
            [
              _buildInfoTile('Versão', '1.0.0'),
              _buildInfoTile('Desenvolvedor', 'MuvviFit Team'),
              _buildActionTile(
                'Política de Privacidade',
                'Como seus dados são utilizados',
                Icons.privacy_tip,
                () {
                  // TODO: Implementar política de privacidade
                },
              ),
              _buildActionTile(
                'Termos de Uso',
                'Termos e condições do app',
                Icons.description,
                () {
                  // TODO: Implementar termos de uso
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppConstants.primaryColor,
      ),
    );
  }

  Widget _buildThemeTile(
    String title,
    String subtitle,
    ThemeMode currentMode,
    Function(ThemeMode) onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<ThemeMode>(
        value: currentMode,
        onChanged: (value) => onChanged(value!),
        items: const [
          DropdownMenuItem(
            value: ThemeMode.system,
            child: Text('Sistema'),
          ),
          DropdownMenuItem(
            value: ThemeMode.light,
            child: Text('Claro'),
          ),
          DropdownMenuItem(
            value: ThemeMode.dark,
            child: Text('Escuro'),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppConstants.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Dados'),
        content: const Text(
          'Tem certeza que deseja remover todos os dados do app? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implementar limpeza de dados
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dados removidos com sucesso'),
                ),
              );
            },
            child: const Text(
              'Limpar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

