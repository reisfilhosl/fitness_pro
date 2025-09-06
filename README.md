# MuvviFit - App de Treino Minimalista

Um aplicativo mobile completo em Flutter para Android e iOS, focado em tracking de treinos de forma minimalista e moderna, com persistência local e gamificação.

## 🚀 Características Principais

- **Offline-first**: Todos os dados são armazenados localmente usando Hive
- **Design Minimalista**: Interface limpa e moderna com foco na experiência do usuário
- **Gamificação**: Sistema de XP, badges e streaks para motivar o usuário
- **Gráficos de Evolução**: Visualização de progresso com fl_chart
- **Cross-platform**: Funciona em Android e iOS
- **Persistência Local**: Dados salvos localmente, sem necessidade de internet

## 📱 Funcionalidades

### Onboarding
- Coleta de dados pessoais (nome, idade, sexo, altura, peso inicial)
- Definição de objetivo (ganhar massa, perder peso, manutenção)

### Navegação Principal
- **Home**: Cards com progresso semanal, peso atual e recordes
- **Atividade**: Painel "Today" e timeline de treinos
- **Gráficos**: Visualização de evolução do peso e cargas
- **Perfil**: Avatar, nível, badges e configurações

### Registro de Treinos
- Seleção de exercícios com busca e filtros
- Modal para adicionar séries (peso, repetições, concluído)
- Timer de descanso opcional
- Cálculo automático de duração e volume total

### Sistema de Exercícios
- 40+ exercícios pré-cadastrados
- Categorias: Aeróbicos e Anaeróbicos
- Grupos musculares: Peito, Costas, Ombros, Braços, Pernas, Core, Cardio
- Unidades: kg, reps, tempo

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Riverpod**: Gerenciamento de estado
- **Hive**: Persistência local
- **fl_chart**: Gráficos e visualizações
- **GoRouter**: Navegação
- **Material Design**: Design system

## 📦 Dependências Principais

```yaml
dependencies:
  flutter_riverpod: ^2.5.1
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  fl_chart: ^0.68.0
  go_router: ^14.2.7
  pdf: ^3.10.7
  printing: ^5.12.0
  csv: ^5.0.2
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.8.1 ou superior
- Dart 3.0 ou superior
- Android Studio / Xcode (para emuladores)

### Instalação

1. **Clone o repositório**
```bash
git clone <url-do-repositorio>
cd muvvifit
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o build_runner (para code generation)**
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

4. **Execute o app**
```bash
flutter run
```

### Comandos Úteis

```bash
# Análise de código
flutter analyze

# Executar testes
flutter test

# Gerar APK de debug
flutter build apk --debug

# Gerar APK de release
flutter build apk --release
```

## 🏗️ Arquitetura

### Estrutura de Pastas
```
lib/
├── core/
│   ├── constants/     # Constantes da aplicação
│   ├── services/      # Serviços (Hive, seeds)
│   └── theme/         # Temas e estilos
├── features/
│   ├── home/          # Tela principal e navegação
│   ├── onboarding/    # Fluxo de onboarding
│   ├── profile/       # Perfil do usuário
│   └── workout/       # Registro de treinos
└── shared/
    ├── models/        # Modelos de dados
    ├── providers/     # Providers do Riverpod
    └── widgets/       # Widgets reutilizáveis
```

### Padrões Utilizados
- **Feature-first**: Organização por funcionalidades
- **Provider Pattern**: Gerenciamento de estado com Riverpod
- **Repository Pattern**: Abstração da camada de dados
- **Model-View-ViewModel**: Separação de responsabilidades

## 🧪 Testes

O projeto inclui testes unitários e widget tests:

```bash
# Executar todos os testes
flutter test

# Executar testes específicos
flutter test test/models/
flutter test test/services/
flutter test test/widgets/
```

### Cobertura de Testes
- ✅ Modelos de dados (User, Workout, Exercise, etc.)
- ✅ Serviços (HiveService, ExerciseSeed, BadgeSeed)
- ✅ Widgets básicos
- ✅ Cálculos de volume e métricas

## 📊 Dados e Persistência

### Modelos Principais
- **User**: Dados pessoais e objetivo
- **Workout**: Sessão de treino com exercícios e séries
- **Exercise**: Exercícios disponíveis
- **WeightEntry**: Registros de peso corporal
- **Badge**: Sistema de conquistas

### Armazenamento Local
- Todos os dados são persistidos localmente usando Hive
- Não há dependência de internet
- Backup automático dos dados

## 🎨 Design System

### Cores
- **Primária**: #E53935 (Vermelho para progresso)
- **Paleta**: Monocromática com destaque em vermelho
- **Dark Mode**: Suporte completo

### Componentes
- Cards reutilizáveis
- Stepper para repetições
- FloatingActionButton para ações principais
- Bottom Navigation com ícones outline/filled

## 📈 Roadmap

### ✅ Implementado
- [x] Estrutura base do projeto
- [x] Models e persistência local
- [x] Seed de exercícios (40+)
- [x] Onboarding completo
- [x] Navegação principal
- [x] Tela de registro de treinos
- [x] Testes unitários e widget tests
- [x] APK de debug

### 🚧 Em Desenvolvimento
- [ ] Sistema de gamificação (XP, badges, streaks)
- [ ] Gráficos com fl_chart
- [ ] Funcionalidades de export (PDF/CSV)
- [ ] CI/CD com GitHub Actions

### 🔮 Futuro
- [ ] Modo "Coach Automático"
- [ ] Sugestões de progressão
- [ ] Analytics básico
- [ ] Notificações locais

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Contato

Para dúvidas ou sugestões, abra uma issue no repositório.

---

**MuvviFit** - Transformando treinos em evolução! 💪