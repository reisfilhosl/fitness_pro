import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/user.dart';

class OnboardingForm extends StatefulWidget {
  final Function(User) onComplete;

  const OnboardingForm({
    super.key,
    required this.onComplete,
  });

  @override
  State<OnboardingForm> createState() => _OnboardingFormState();
}

class _OnboardingFormState extends State<OnboardingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  
  Gender _selectedGender = Gender.male;
  FitnessGoal _selectedGoal = FitnessGoal.buildMuscle;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text),
        gender: _selectedGender,
        height: double.parse(_heightController.text),
        initialWeight: double.parse(_weightController.text),
        goal: _selectedGoal,
        createdAt: DateTime.now(),
      );
      
      widget.onComplete(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nome
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu nome',
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
                hintText: 'Digite sua idade',
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
            
            // Sexo
            DropdownButtonFormField<Gender>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Sexo',
                prefixIcon: Icon(Icons.person_outline),
              ),
              items: Gender.values.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender.displayName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Altura
            TextFormField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Altura',
                hintText: 'Digite sua altura',
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
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Peso
            TextFormField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Peso',
                hintText: 'Digite seu peso',
                prefixIcon: Icon(Icons.monitor_weight),
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Peso é obrigatório';
                }
                final weight = double.tryParse(value);
                if (weight == null || weight < 30 || weight > 300) {
                  return 'Peso deve ser entre 30 e 300 kg';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Objetivo
            DropdownButtonFormField<FitnessGoal>(
              value: _selectedGoal,
              decoration: const InputDecoration(
                labelText: 'Objetivo',
                prefixIcon: Icon(Icons.flag),
              ),
              items: FitnessGoal.values.map((goal) {
                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal.displayName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGoal = value!;
                });
              },
            ),
            const SizedBox(height: AppConstants.largePadding),
            
            // Botão Finalizar
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Começar Jornada',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

