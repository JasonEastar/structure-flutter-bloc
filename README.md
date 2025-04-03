# Cấu trúc code chi tiết cho dự án "Thèm"

Dưới đây là cấu trúc thư mục và file chi tiết cho dự án, bao gồm giải thích chức năng của từng thư mục và file:

## 1. Thư mục gốc

```
them/
├── android/                   # Mã nguồn native Android
├── ios/                       # Mã nguồn native iOS
├── assets/                    # Tài nguyên tĩnh của ứng dụng
│   ├── images/                # Hình ảnh, icon, logo
│   │   ├── logo.png           # Logo chính của ứng dụng
│   │   ├── logo_dark.png      # Logo cho dark mode
│   │   ├── default_avatar.png # Avatar mặc định
│   │   └── markers/           # Icon cho map markers
│   ├── fonts/                 # Phông chữ tùy chỉnh
│   │   ├── Montserrat-Regular.ttf
│   │   ├── Montserrat-Bold.ttf
│   │   ├── Montserrat-Medium.ttf
│   │   └── Montserrat-Light.ttf
│   └── translations/          # File đa ngôn ngữ (nếu cần)
├── lib/                       # Mã nguồn Dart chính của ứng dụng
├── test/                      # Tests (unit, widget, integration)
├── pubspec.yaml               # Quản lý dependencies và cấu hình ứng dụng
├── analysis_options.yaml      # Cấu hình linting và phân tích code
├── .env                       # Biến môi trường (không commit)
├── .env.example               # Mẫu file .env (có thể commit)
├── README.md                  # Tài liệu dự án
└── .gitignore                 # Cấu hình Git ignore

```

## 2. Thư mục `/lib` (Mã nguồn chính)

### 2.1. `/lib/app` - Cấu hình ứng dụng

```
app/
├── app.dart                  # Root widget, cấu hình MaterialApp
├── app_bloc_observer.dart    # BLoC observer cho debugging
└── router/                   # Quản lý routing
    ├── app_router.dart       # Cấu hình GoRouter
    └── app_routes.dart       # Định nghĩa tên routes ("/home", "/profile", etc.)

```

**Chức năng các file:**

- `app.dart`: Widget gốc của ứng dụng, setup theme, localization, và routing
- `app_bloc_observer.dart`: Ghi log sự kiện BLoC cho việc debug
- `app_router.dart`: Quản lý navigation, cấu hình các routes
- `app_routes.dart`: Định nghĩa constants cho các routes

### 2.2. `/lib/config` - Cấu hình và constants

```
config/
├── env/                      # Cấu hình môi trường
│   ├── env_config.dart       # Interface cho môi trường
│   ├── dev_env.dart          # Cấu hình môi trường development
│   ├── prod_env.dart         # Cấu hình môi trường production
│   └── env.dart              # Export env hiện tại
├── theme/                    # Theme ứng dụng
│   ├── app_colors.dart       # Bảng màu (primary, secondary, etc.)
│   ├── app_text_styles.dart  # Định nghĩa style văn bản
│   ├── app_theme.dart        # Theme data (light/dark)
│   └── app_dimensions.dart   # Kích thước, margin, padding chuẩn
└── constants/                # Hằng số ứng dụng
    ├── api_constants.dart    # Endpoints API, headers
    ├── app_constants.dart    # Hằng số ứng dụng
    ├── asset_constants.dart  # Đường dẫn đến assets
    ├── mapbox_constants.dart # Mapbox API key, styles
    └── storage_constants.dart # Keys cho local storage

```

**Chức năng các file:**

- Thư mục `env/`: Quản lý biến môi trường khác nhau (dev/prod)
- Thư mục `theme/`: Định nghĩa giao diện ứng dụng
- Thư mục `constants/`: Lưu trữ các hằng số, tránh hardcode

### 2.3. `/lib/core` - Các chức năng cốt lõi

```
core/
├── error/                    # Xử lý lỗi
│   ├── exceptions.dart       # Custom exceptions
│   └── failures.dart         # Domain failures
├── network/                  # Xử lý network
│   ├── api_client.dart       # Interface cho API client
│   ├── dio_client.dart       # Cài đặt với Dio
│   └── interceptors/         # Dio interceptors
│       ├── auth_interceptor.dart # Xử lý authentication tokens
│       └── logging_interceptor.dart # Log requests/responses
├── storage/                  # Lưu trữ local
│   ├── secure_storage.dart   # Lưu trữ bảo mật (tokens)
│   ├── local_storage.dart    # Interface chung
│   ├── hive_storage.dart     # Cài đặt với Hive
│   └── preferences_storage.dart # Cài đặt với SharedPreferences
├── utils/                    # Utility functions
│   ├── date_utils.dart       # Xử lý thời gian
│   ├── location_utils.dart   # Xử lý vị trí
│   ├── permission_utils.dart # Xử lý quyền
│   └── logger_utils.dart     # Logging
└── extensions/               # Dart extensions
    ├── context_extensions.dart # Extensions cho BuildContext
    ├── string_extensions.dart  # Extensions cho String
    └── datetime_extensions.dart # Extensions cho DateTime

```

**Chức năng các file:**

- Thư mục `error/`: Xử lý lỗi trong ứng dụng
- Thư mục `network/`: Quản lý giao tiếp API
- Thư mục `storage/`: Quản lý lưu trữ local
- Thư mục `utils/`: Các hàm tiện ích
- Thư mục `extensions/`: Mở rộng các class có sẵn

### 2.4. `/lib/data` - Tầng data

```
data/
├── datasources/             # Nguồn dữ liệu
│   ├── local/               # Nguồn local
│   │   ├── auth_local_datasource.dart # Authentication local
│   │   ├── post_local_datasource.dart # Post local
│   │   └── settings_local_datasource.dart # Settings local
│   └── remote/              # Nguồn remote (API)
│       ├── auth_remote_datasource.dart # Authentication API
│       ├── post_remote_datasource.dart # Post API
│       ├── livestream_remote_datasource.dart # Livestream API
│       └── map_remote_datasource.dart # Map API
├── models/                  # Data models
│   ├── auth/
│   │   ├── user_model.dart  # Model cho user
│   │   └── token_model.dart # Model cho authentication tokens
│   ├── post/
│   │   ├── post_model.dart  # Model cho bài đăng
│   │   └── comment_model.dart # Model cho bình luận
│   ├── livestream/
│   │   ├── room_model.dart  # Model cho phòng livestream
│   │   └── stream_model.dart # Model cho livestream
│   └── map/
│       └── location_model.dart # Model cho vị trí
└── repositories/            # Cài đặt repositories
    ├── auth_repository_impl.dart # Cài đặt authentication repository
    ├── post_repository_impl.dart # Cài đặt post repository
    ├── livestream_repository_impl.dart # Cài đặt livestream repository
    └── map_repository_impl.dart # Cài đặt map repository

```

**Chức năng các file:**

- Thư mục `datasources/`: Định nghĩa các nguồn dữ liệu
- Thư mục `models/`: Định nghĩa cấu trúc dữ liệu
- Thư mục `repositories/`: Cài đặt các repository interfaces từ domain layer

### 2.5. `/lib/domain` - Tầng business logic

```
domain/
├── entities/                # Business entities
│   ├── auth/
│   │   ├── user_entity.dart # Entity cho user
│   │   └── token_entity.dart # Entity cho authentication tokens
│   ├── post/
│   │   ├── post_entity.dart # Entity cho bài đăng
│   │   └── comment_entity.dart # Entity cho bình luận
│   ├── livestream/
│   │   ├── room_entity.dart # Entity cho phòng livestream
│   │   └── stream_entity.dart # Entity cho livestream
│   └── map/
│       └── location_entity.dart # Entity cho vị trí
├── repositories/            # Repository interfaces
│   ├── auth_repository.dart # Interface cho authentication repository
│   ├── post_repository.dart # Interface cho post repository
│   ├── livestream_repository.dart # Interface cho livestream repository
│   └── map_repository.dart  # Interface cho map repository
└── usecases/                # Business logic use cases
    ├── auth/
    │   ├── login_usecase.dart # Use case đăng nhập
    │   ├── register_usecase.dart # Use case đăng ký
    │   └── logout_usecase.dart # Use case đăng xuất
    ├── post/
    │   ├── create_post_usecase.dart # Use case tạo bài đăng
    │   ├── get_posts_usecase.dart # Use case lấy bài đăng
    │   └── delete_post_usecase.dart # Use case xóa bài đăng
    ├── livestream/
    │   ├── create_livestream_usecase.dart # Use case tạo livestream
    │   └── join_livestream_usecase.dart # Use case tham gia livestream
    └── map/
        └── get_nearby_posts_usecase.dart # Use case lấy bài đăng gần đó

```

**Chức năng các file:**

- Thư mục `entities/`: Định nghĩa các đối tượng nghiệp vụ
- Thư mục `repositories/`: Định nghĩa interfaces cho repositories
- Thư mục `usecases/`: Các logic nghiệp vụ cụ thể

### 2.6. `/lib/features` - Các tính năng

```
features/
├── splash/                  # Màn hình splash
│   └── splash_screen.dart   # Màn hình khởi động
├── auth/                    # Tính năng authentication
│   ├── bloc/                # State management
│   │   ├── auth_bloc.dart   # BLoC xử lý auth
│   │   ├── auth_event.dart  # Events cho auth BLoC
│   │   └── auth_state.dart  # States cho auth BLoC
│   ├── pages/               # Các màn hình
│   │   ├── login_page.dart  # Màn hình đăng nhập
│   │   └── register_page.dart # Màn hình đăng ký
│   └── widgets/             # Widgets riêng cho auth
│       └── social_login_button.dart # Button đăng nhập bằng social
├── map/                     # Tính năng maps
│   ├── bloc/                # State management
│   │   ├── map_bloc.dart    # BLoC xử lý map
│   │   ├── map_event.dart   # Events cho map BLoC
│   │   └── map_state.dart   # States cho map BLoC
│   ├── pages/               # Các màn hình
│   │   └── map_page.dart    # Màn hình bản đồ chính
│   └── widgets/             # Widgets riêng cho map
│       ├── post_marker.dart # Marker cho bài đăng
│       └── cluster_marker.dart # Marker cho nhóm bài đăng
├── post/                    # Tính năng post
│   ├── bloc/                # State management
│   │   ├── post_bloc.dart   # BLoC xử lý post
│   │   ├── post_event.dart  # Events cho post BLoC
│   │   └── post_state.dart  # States cho post BLoC
│   ├── pages/               # Các màn hình
│   │   ├── create_post_page.dart # Màn hình tạo bài đăng
│   │   └── post_detail_page.dart # Màn hình chi tiết bài đăng
│   └── widgets/             # Widgets riêng cho post
│       ├── post_card.dart   # Card hiển thị bài đăng
│       └── media_picker.dart # Widget chọn media
└── livestream/              # Tính năng livestream
    ├── bloc/                # State management
    │   ├── livestream_bloc.dart # BLoC xử lý livestream
    │   ├── livestream_event.dart # Events cho livestream BLoC
    │   └── livestream_state.dart # States cho livestream BLoC
    ├── pages/               # Các màn hình
    │   ├── livestream_page.dart # Màn hình livestream
    │   └── karaoke_page.dart # Màn hình karaoke
    └── widgets/             # Widgets riêng cho livestream
        ├── stream_controls.dart # Controls cho livestream
        └── audience_list.dart # Danh sách người xem

```

**Chức năng các file:**

- Thư mục cho từng tính năng chính (auth, map, post, livestream)
- Mỗi tính năng có thư mục con:
    - `bloc/`: Quản lý state
    - `pages/`: Các màn hình UI
    - `widgets/`: Các widget riêng

### 2.7. `/lib/presentation` - UI chung

```
presentation/
├── widgets/                 # Widgets dùng chung
│   ├── app_bar.dart         # Custom app bar
│   ├── loading_indicator.dart # Indicator loading
│   ├── error_view.dart      # Hiển thị lỗi
│   └── empty_state.dart     # Hiển thị trạng thái trống
└── navigation/              # Navigation widgets
    ├── bottom_nav_bar.dart  # Bottom navigation
    └── drawer_menu.dart     # Drawer menu

```

**Chức năng các file:**

- Thư mục `widgets/`: Các widget dùng chung trong nhiều tính năng
- Thư mục `navigation/`: Các widget điều hướng dùng chung

### 2.8. `/lib/l10n` - Internationalization

```
l10n/
├── app_en.arb               # Ngôn ngữ tiếng Anh
└── app_vi.arb               # Ngôn ngữ tiếng Việt

```

**Chức năng các file:**

- File ngôn ngữ cho nhiều locale khác nhau

### 2.9. `/lib` - Files gốc

```
lib/
├── injection.dart           # Cấu hình dependency injection
├── injection.config.dart    # Generated DI code
└── main.dart                # Entry point của ứng dụng

```

**Chức năng các file:**

- `injection.dart`: Setup dependency injection với get_it và injectable
- `injection.config.dart`: File tự động sinh ra bởi injectable
- `main.dart`: Điểm khởi đầu của ứng dụng, khởi tạo các services cần thiết