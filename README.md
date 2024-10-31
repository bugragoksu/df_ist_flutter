# Flutter Clean Architecture Example

This project demonstrates the implementation of Clean Architecture in Flutter, showcasing best practices for building scalable and maintainable applications.

## Clean Architecture Overview

Clean Architecture, proposed by Robert C. Martin, divides the application into concentric layers, each with its own responsibility. In this Flutter implementation, we have organized the code into the following layers:

### 1. Presentation Layer
Located in `lib/src/features/*/presentation/`
- Contains UI components (screens, widgets)
- Contains state management (Cubit/BLoC)
- Depends on Domain layer
- No business logic

Files explained:
- `user_screen.dart`: UI implementation using BlocBuilder to react to state changes. Displays user data and handles user interactions.
- `user_cubit.dart`: Manages UI state and communicates with use cases. Implements business logic workflows.
- `user_state.dart`: Defines possible states (initial, loading, loaded, error) using Freezed for immutability.

### 2. Domain Layer
Located in `lib/src/features/*/domain/`
- Contains business logic
- Defines abstract repositories
- Contains use cases
- Contains business models
- Pure Dart code (no Flutter dependencies)

Files explained:
- `user_model.dart`: Business model representing a user with core properties (id, name, email).
- `user_repository.dart`: Abstract definition of repository methods, defining the contract for data operations.
- `get_user_usecase.dart`: Single responsibility class implementing the specific use case of retrieving user data.

### 3. Data Layer
Located in `lib/src/features/*/data/`
- Implements repositories
- Manages data sources
- Handles data transformation
- Contains DTOs (Data Transfer Objects)

Files explained:
- `user_repository_impl.dart`: Concrete implementation of UserRepository, orchestrating data sources.
- `user_remote_data_source.dart`: Handles API calls using ApiClient for remote data fetching.
- `user_local_data_source.dart`: Manages local storage using SharedPreferences for caching.
- `user_dto.dart`: Data Transfer Object for serialization/deserialization of user data.

### 4. Core Layer
Located in `lib/src/core/`
- Contains app-wide utilities and configurations
- Implements cross-cutting concerns

Files explained:
- `locator.dart`: Configures dependency injection using get_it and injectable.
- `api_client.dart`: Wrapper around Dio for making HTTP requests.
- `failure.dart`: Common error handling model.

## Detailed Component Analysis

### Dependency Injection
The project uses GetIt and Injectable for dependency injection:

```dart
// locator.dart
@InjectableInit()
void configureDependencies() => getIt.init(environment: Environment.dev);
```

Benefits:
- Centralized dependency management
- Automated dependency registration
- Easy testing through dependency substitution
- Support for different environments (dev, prod)

### Data Flow Explanation

1. **UI Layer Flow**
```dart
// user_screen.dart
FloatingActionButton(
  onPressed: () {
    context.read<UserCubit>().getUser(1);
  },
  child: const Icon(Icons.refresh),
)
```

2. **State Management Flow**
```dart
// user_cubit.dart
Future<void> getUser(int id) async {
  emit(const UserState.loading());
  final result = await _getUserUsecase(id);
  result.fold(
    (failure) => emit(UserState.error(failure.message)),
    (user) => emit(UserState.loaded(user)),
  );
}
```

3. **Repository Pattern Flow**
```dart
// user_repository_impl.dart
@override
Future<Either<Failure, UserModel>> getUser(int id) async {
  try {
    final cachedUser = await localDataSource.getCachedUser();
    if (cachedUser != null) {
      return Right(cachedUser.toModel());
    }
    final remoteUser = await remoteDataSource.getUser(id);
    await localDataSource.cacheUser(remoteUser);
    return Right(remoteUser.toModel());
  } catch (e) {
    return Left(Failure(message: e.toString()));
  }
}
```

### Error Handling Strategy

1. **Data Layer Errors**
```dart
// user_remote_data_source.dart
try {
  final response = await apiClient.get('/users/$id');
  return UserDto.fromJson(response.data);
} catch (e) {
  throw Exception("Failed to load user data");
}
```

2. **Domain Layer Errors**
- Using Either type for error handling
- Consistent error propagation
- Type-safe error handling

3. **Presentation Layer Errors**
```dart
// user_screen.dart
state.when(
  error: (message) => Center(
    child: Text("Error: $message"),
  ),
  // ... other states
);
```

### Testing Strategy

1. **Unit Tests Example**
```dart
void main() {
  group('UserRepository', () {
    late UserRepositoryImpl repository;
    late MockRemoteDataSource mockRemoteDataSource;
    late MockLocalDataSource mockLocalDataSource;

    setUp(() {
      mockRemoteDataSource = MockRemoteDataSource();
      mockLocalDataSource = MockLocalDataSource();
      repository = UserRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
      );
    });

    test('should return cached user when available', () async {
      // Test implementation
    });
  });
}
```

2. **Integration Tests**
- Test component interactions
- Verify data flow
- Test caching behavior

3. **Widget Tests**
- Test UI components
- Verify state management
- Test user interactions

### Project Setup Guide

1. **Clone and Dependencies**
```bash
# Clone the repository
git clone https://github.com/yourusername/flutter-clean-architecture.git

# Get dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs
```

2. **Required Dependencies**
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

### Best Practices

1. **Code Organization**
- Feature-first architecture
- Clear layer separation
- Consistent naming conventions

2. **Clean Code Principles**
- Single Responsibility
- Dependency Inversion
- Interface Segregation
- DRY (Don't Repeat Yourself)

3. **Performance Considerations**
- Efficient caching strategies
- Proper resource disposal
- Minimal rebuilds

### Contributing Guidelines

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Resources and References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Documentation](https://flutter.dev/docs)
- [Bloc Library Documentation](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)

### License

This project is licensed under the MIT License - see the LICENSE file for details.

### Support

For support, please open an issue in the repository.