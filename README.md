# Flutter Clean Architecture Example

## Overview

This project demonstrates the implementation of Clean Architecture in Flutter, showcasing best practices for building scalable and maintainable applications.

[View Detailed Presentation](https://www.canva.com/design/DAGVPMmu1_0/_ycfLlzaTkw1YeJtYDE4JA/edit)

## Clean Architecture Overview

Clean Architecture, proposed by Robert C. Martin, divides the application into concentric layers, each with its own responsibility:

```
┌──────────────────────────────────────────┐
│              Clean Architecture          │
│                                          │
│  ┌─────────────┐                         │
│  │             │                         │
│  │     UI      │   Presentation Layer    │
│  │             │                         │
│  └─────────────┘                         │
│         ↑                                │
│  ┌─────────────┐                         │
│  │             │                         │
│  │  Use Cases  │     Domain Layer        │
│  │             │                         │
│  └─────────────┘                         │
│         ↑                                │
│  ┌─────────────┐                         │
│  │             │                         │
│  │    Data     │      Data Layer         │
│  │             │                         │
│  └─────────────┘                         │
│                                          │
└──────────────────────────────────────────┘
```

### 1. Presentation Layer
Located in `lib/src/features/*/presentation/`
```
┌────────────────────────────────────┐
│        Presentation Layer          │
│                                    │
│  ┌────────────┐    ┌────────────┐  │
│  │            │    │            │  │
│  │  Widgets   │←───│   Cubit    │  │
│  │            │    │            │  │
│  └────────────┘    └────────────┘  │
│         ↑               ↑          │
│  ┌────────────┐    ┌────────────┐  │
│  │            │    │            │  │
│  │  Screens   │    │   State    │  │
│  │            │    │            │  │
│  └────────────┘    └────────────┘  │
└────────────────────────────────────┘
```

Files explained:
- `user_screen.dart`: UI implementation using BlocBuilder to react to state changes
- `user_cubit.dart`: Manages UI state and communicates with use cases
- `user_state.dart`: Defines possible states using Freezed for immutability

Example:
```dart
class UserCubit extends Cubit<UserState> {
  final GetUserUsecase _getUserUsecase;

  Future<void> getUser(int id) async {
    emit(const UserState.loading());
    final result = await _getUserUsecase(id);
    result.fold(
      (failure) => emit(UserState.error(failure.message)),
      (user) => emit(UserState.loaded(user)),
    );
  }
}
```

### 2. Domain Layer
Located in `lib/src/features/*/domain/`
```
┌────────────────────────────────────┐
│          Domain Layer              │
│                                    │
│  ┌────────────┐    ┌────────────┐  │
│  │            │    │            │  │
│  │ Use Cases  │←───│  Models    │  │
│  │            │    │            │  │
│  └────────────┘    └────────────┘  │
│         ↑                          │
│  ┌────────────┐                    │
│  │            │                    │
│  │Repository  │                    │
│  │Interfaces  │                    │
│  └────────────┘                    │
└────────────────────────────────────┘
```

Files explained:
- `user_model.dart`: Business model representing a user
- `user_repository.dart`: Abstract definition of repository methods
- `get_user_usecase.dart`: Single responsibility class for getting user data

### 3. Data Layer
Located in `lib/src/features/*/data/`
```
┌────────────────────────────────────┐
│           Data Layer               │
│                                    │
│  ┌────────────┐    ┌────────────┐  │
│  │            │    │            │  │
│  │Repository  │←───│    DTO     │  │
│  │   Impl     │    │            │  │
│  └────────────┘    └────────────┘  │
│         ↑               ↑          │
│  ┌────────────┐    ┌────────────┐  │
│  │  Remote    │    │   Local    │  │
│  │Data Source │    │Data Source │  │
│  └────────────┘    └────────────┘  │
└────────────────────────────────────┘
```

Files explained:
- `user_repository_impl.dart`: Concrete implementation of UserRepository
- `user_remote_data_source.dart`: Handles API calls
- `user_local_data_source.dart`: Manages local storage
- `user_dto.dart`: Data Transfer Object for serialization/deserialization

## Data Flow
```
┌──────────┐    ┌──────────┐    ┌──────────┐
│          │    │          │    │          │
│   UI     │───→│  Cubit   │───→│ UseCase  │
│          │    │          │    │          │
└──────────┘    └──────────┘    └──────────┘
                                      │
┌──────────┐    ┌──────────┐          │
│          │    │          │          ▼
│  Remote  │◀───│Repository│◀─────────┘
│   API    │    │          │
└──────────┘    └──────────┘
                      ↑
                ┌──────────┐
                │  Local   │
                │  Cache   │
                └──────────┘
```

## Testing Strategy
```
┌────────────────────────────────────┐
│         Testing Strategy           │
│                                    │
│  ┌────────────┐    ┌────────────┐  │
│  │   Unit     │    │Integration │  │
│  │   Tests    │    │   Tests    │  │
│  └────────────┘    └────────────┘  │
│                                    │
│  ┌────────────┐    ┌────────────┐  │
│  │  Widget    │    │    E2E     │  │
│  │   Tests    │    │   Tests    │  │ 
│  └────────────┘    └────────────┘  │
└────────────────────────────────────┘
```

## Project Setup

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  bloc: ^8.0.0
  flutter_bloc: ^8.0.0
  get_it: ^7.2.0
  injectable: ^1.5.3
  dio: ^4.0.6
  shared_preferences: ^2.0.15
  freezed_annotation: ^2.2.0
  json_annotation: ^4.7.0
  dartz: ^0.10.1

dev_dependencies:
  build_runner: ^2.3.3
  injectable_generator: ^1.5.4
  freezed: ^2.3.2
  json_serializable: ^6.5.4
```

### Installation
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

## Best Practices

### 1. SOLID Principles
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

### 2. Code Organization
- Feature-first architecture
- Clear layer separation
- Consistent naming conventions

### 3. Performance
- Efficient caching strategies
- Proper resource disposal
- Minimal rebuilds

## Common Pitfalls to Avoid
1. Mixing layers
2. Skipping abstraction
3. Improper error handling
4. Complex repositories
5. Tight coupling

## Resources
- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Documentation](https://flutter.dev/docs)
- [Bloc Library](https://bloclibrary.dev/)
- [GetIt Package](https://pub.dev/packages/get_it)
- [Project Presentation](https://www.canva.com/design/DAGVPMmu1_0/_ycfLlzaTkw1YeJtYDE4JA/edit?utm_content=DAGVPMmu1_0&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton)

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create Pull Request

## License
MIT License - see LICENSE file