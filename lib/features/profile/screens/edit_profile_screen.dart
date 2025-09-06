import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = ref.read(userProvider);
    if (user != null) {
      _nameController.text = user.name;
      _ageController.text = user.age.toString();
      _heightController.text = user.height.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('Salvar'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppConstants.primaryColor,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Nome
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  if (value.trim().length < 2) {
                    return 'Nome deve ter pelo menos 2 caracteres';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Idade
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  prefixIcon: Icon(Icons.cake),
                  suffixText: 'anos',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Idade é obrigatória';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 13 || age > 120) {
                    return 'Idade deve ser entre 13 e 120 anos';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.defaultPadding),
              
              // Altura
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Altura',
                  prefixIcon: Icon(Icons.height),
                  suffixText: 'cm',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Altura é obrigatória';
                  }
                  final height = double.tryParse(value);
                  if (height == null || height < 100 || height > 250) {
                    return 'Altura deve ser entre 100 e 250 cm';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Informações não editáveis
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informações do Sistema',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppConstants.defaultPadding),
                      _buildInfoRow('Membro desde', '${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}'),
                      _buildInfoRow('Nível atual', '${user.level}'),
                      _buildInfoRow('XP total', '${user.totalXP}'),
                      _buildInfoRow('Maior streak', '${user.longestStreak} dias'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = ref.read(userProvider);
      if (user == null) return;

      final updatedUser = user.copyWith(
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
      );

      await ref.read(userProvider.notifier).updateUser(updatedUser);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: AppConstants.primaryColor,
          ),
        );
      }
    }
  }
}
