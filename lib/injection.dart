// lib/injection.dart
import 'package:get_it/get_it.dart';
import 'package:them/app/cubit/locale_cubit.dart';
import 'package:them/app/router/app_router.dart';
import 'package:them/core/network/dio_client.dart';
import 'package:them/core/storage/secure_storage.dart';
import 'package:them/data/datasources/local/auth_local_datasource.dart';
import 'package:them/data/datasources/remote/auth_remote_datasource.dart';
import 'package:them/data/repositories/auth_repository_impl.dart';
import 'package:them/domain/repositories/auth_repository.dart';
import 'package:them/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:them/domain/usecases/auth/is_logged_in_usecase.dart';
import 'package:them/domain/usecases/auth/login_usecase.dart';
import 'package:them/domain/usecases/auth/logout_usecase.dart';
import 'package:them/features/auth/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

/// Thiết lập dependency injection
void setupDependencies() {
  // Core
  getIt.registerSingleton<SecureStorage>(SecureStorage());
  getIt.registerSingleton<DioClient>(DioClient());

 // Localization
  getIt.registerSingleton<LocaleCubit>(LocaleCubit()); // Thêm dòng này
  
  // Data sources
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(getIt<SecureStorage>()),
  );
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<DioClient>().dio),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // Use cases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<LogoutUseCase>(
    LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<IsLoggedInUseCase>(
    IsLoggedInUseCase(getIt<AuthRepository>()),
  );

  // Cubits
  getIt.registerSingleton<AuthCubit>(
    AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      isLoggedInUseCase: getIt<IsLoggedInUseCase>(),
    ),
  );

  // Router
  getIt.registerSingleton<AppRouter>(
    AppRouter(getIt<AuthCubit>()),
  );
}