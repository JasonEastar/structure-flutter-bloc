# Danh sách công nghệ và packages thiết yếu cho dự án "Thèm"

## Cấu trúc và State Management

- **flutter_bloc**: Quản lý state sử dụng BLoC pattern
- **equatable**: So sánh objects dễ dàng trong BLoC, tránh rebuild UI không cần thiết
- **get_it** + **injectable**: Dependency injection, quản lý các services, repositories trong Clean Architecture

## Maps & Location

- **mapbox_gl**: SDK chính để tích hợp bản đồ Mapbox
- **geolocator**: Lấy vị trí người dùng
- **geocoding**: Chuyển đổi tọa độ thành địa chỉ và ngược lại

## Authentication

- **firebase_auth**: Quản lý xác thực người dùng
- **firebase_core**: Khởi tạo Firebase
- **google_sign_in**: OAuth2 với Google
- **flutter_facebook_auth**: OAuth2 với Facebook
- **flutter_secure_storage**: Lưu trữ token an toàn

## Networking

- **dio**: HTTP client nâng cao với interceptors, cancel tokens, FormData
- **json_serializable** + **build_runner**: Tự động tạo code chuyển đổi JSON
- **flutter_dotenv**: Quản lý biến môi trường

## Local Storage

- **hive** + **hive_flutter**: Database NoSQL nhẹ và nhanh
- **shared_preferences**: Lưu trữ đơn giản cho settings

## Media Handling

- **image_picker**: Chọn ảnh/video từ gallery hoặc camera
- **cached_network_image**: Tối ưu việc tải và hiển thị ảnh
- **video_player**: Phát video

## Livestream

- **tencent_trtc_cloud**: SDK chính cho livestream
- **tencent_im_sdk_plugin**: Chat trong livestream (nếu cần)

## UI/UX Essentials

- **flutter_native_splash**: Tạo splash screen
- **connectivity_plus**: Kiểm tra kết nối internet

## Internationalization

- **flutter_localizations**: Package cơ bản cho đa ngôn ngữ
- **intl**: Hỗ trợ định dạng ngày, số, và strings

## Utils

- **permission_handler**: Xin quyền (vị trí, camera, mic)
- **logger**: Logging nâng cao, hỗ trợ debug

## Navigation

- **go_router**: Navigation và deep linking

## Thứ tự triển khai:

1. **Cơ sở dự án**: Cấu trúc thư mục, DI, theme, routing
2. **Splash Screen & Đa ngôn ngữ**: Setup ban đầu
3. **Authentication**: Đăng nhập, đăng ký với Firebase Auth
4. **Map & Location**: Tích hợp Mapbox, hiển thị vị trí
5. **Post Creation**: Tạo và hiển thị bài đăng trên bản đồ
6. **Livestream**: Tích hợp Tencent TRTC, quản lý phiên livestream

Danh sách này đã được tinh gọn để chỉ bao gồm các packages thiết yếu cho dự án "Thèm". Những packages khác có thể được thêm vào sau khi dự án đã phát triển tới giai đoạn có nhu cầu cụ thể.

---

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

## 3. `main.dart` - File khởi động ứng dụng

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:them/app/app.dart';
import 'package:them/app/app_bloc_observer.dart';
import 'package:them/injection.dart';

Future<void> main() async {
  // Đảm bảo Flutter binding đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  // Cấu hình dependency injection
  configureDependencies();

  // Thiết lập BLoC observer
  Bloc.observer = AppBlocObserver();

  // Chạy ứng dụng
  runApp(const App());
}

```

Đây là cấu trúc chi tiết cho dự án "Thèm" của bạn, với các file và thư mục cụ thể cùng chức năng của chúng. Cấu trúc này tuân theo Feature-first Clean Architecture, giúp tách biệt rõ ràng các tầng, dễ dàng mở rộng và bảo trì.

---

Hãy phân tích từng package mà bạn đã liệt kê để xem chúng được sử dụng làm gì và mức độ cần thiết cho dự án "Thèm":

### Packages thiết yếu, nên giữ lại:

1. **equatable**:
    - Dùng để: Giúp so sánh objects một cách đơn giản trong BLoC/Cubit (xác định khi nào state thay đổi)
    - Cần thiết: **Rất cần** cho state management, giúp tránh rebuild UI không cần thiết
    - Ví dụ: Khi so sánh hai state trong BLoC
2. **get_it** + **injectable**:
    - Dùng để: Dependency injection, quản lý các instance của services, repositories và BLoCs
    - Cần thiết: **Rất cần** cho dự án có cấu trúc Clean Architecture
    - Ví dụ: Truy cập repositories từ bất kỳ đâu trong ứng dụng mà không cần truyền tham số
3. **dio**:
    - Dùng để: Thực hiện HTTP requests, cải thiện so với http package mặc định
    - Cần thiết: **Cần** cho APIs phức tạp, hỗ trợ interceptors, cancel tokens, form data
    - Ví dụ: Gọi API, upload file, xử lý lỗi và token
4. **json_serializable** + **build_runner**:
    - Dùng để: Tự động tạo code chuyển đổi JSON sang objects và ngược lại
    - Cần thiết: **Cần** cho dự án có nhiều models để tránh viết code thủ công
    - Ví dụ: Tự động tạo các hàm fromJson và toJson cho data models
5. **connectivity_plus**:
    - Dùng để: Kiểm tra kết nối internet
    - Cần thiết: **Nên có** cho ứng dụng cần hoạt động offline/online
    - Ví dụ: Hiển thị thông báo khi không có kết nối mạng

### Packages có ích, tùy theo yêu cầu:

1. **retrofit**:
    - Dùng để: Tạo API clients tự động, giảm boilerplate code
    - Cần thiết: **Có thể thay thế** bằng cách sử dụng Dio trực tiếp, nhưng tiện lợi hơn
    - Ví dụ: Định nghĩa API endpoints dưới dạng interface
2. **flutter_screenutil**:
    - Dùng để: Làm responsive UI trên nhiều kích thước màn hình
    - Cần thiết: **Nên có** nếu cần hỗ trợ nhiều kích thước màn hình
    - Ví dụ: Điều chỉnh font size, widget size theo màn hình
3. **shimmer**:
    - Dùng để: Tạo hiệu ứng loading đẹp mắt
    - Cần thiết: **Nice to have**, cải thiện trải nghiệm người dùng
    - Ví dụ: Hiệu ứng loading placeholder khi chờ data
4. **logger**:
    - Dùng để: Logging có màu sắc, dễ đọc hơn print()
    - Cần thiết: **Nên có** cho debugging và phát triển
    - Ví dụ: Log network requests, errors một cách rõ ràng
5. **flutter_svg**:
    - Dùng để: Hiển thị SVG icons và hình ảnh vector
    - Cần thiết: **Nên có** nếu dự án sử dụng SVG
    - Ví dụ: Sử dụng SVG icons thay vì PNG để tránh mờ khi phóng to
6. **uuid**:
    - Dùng để: Tạo các ID duy nhất
    - Cần thiết: **Có thể cần** cho các tính năng tạm thời, nhất là khi offline
    - Ví dụ: Tạo ID tạm cho post khi chưa gửi lên server

### Packages có thể bỏ qua nếu không cần:

1. **url_launcher**:
    - Dùng để: Mở URLs, email, phone calls từ app
    - Cần thiết: **Tùy theo yêu cầu**, chỉ cần nếu có liên kết ngoài
    - Ví dụ: Mở trang web từ profile người dùng
2. **flutter_keyboard_visibility**:
    - Dùng để: Theo dõi trạng thái hiển thị bàn phím
    - Cần thiết: **Tùy theo UI**, chỉ cần nếu có xử lý đặc biệt với bàn phím
    - Ví dụ: Thay đổi UI khi bàn phím hiện lên

Kết luận: Tôi khuyên nên giữ lại 5 packages đầu tiên và đánh giá các packages còn lại dựa trên yêu cầu cụ thể của dự án "Thèm". Trong quá trình phát triển, bạn có thể thêm các packages khi cần thiết thay vì thêm tất cả ngay từ đầu.

---

# Danh sách công nghệ và thư viện cho dự án "Thèm"

## Cấu trúc và State Management

- **flutter_bloc**: Quản lý state sử dụng BLoC pattern
- **equatable**: Giúp so sánh objects dễ dàng trong BLoC
- **get_it** + **injectable**: Dependency injection

## Maps & Location

- **mapbox_gl**: SDK chính để tích hợp bản đồ Mapbox
- **geolocator**: Lấy vị trí người dùng
- **geocoding**: Chuyển đổi tọa độ thành địa chỉ và ngược lại

## Authentication

- **firebase_auth**: Quản lý xác thực người dùng
- **firebase_core**: Khởi tạo Firebase
- **google_sign_in**: OAuth2 với Google
- **flutter_facebook_auth**: OAuth2 với Facebook
- **flutter_secure_storage**: Lưu trữ token an toàn

## Networking

- **dio**: HTTP client nâng cao
- **retrofit**: Giảm boilerplate code cho API calls
- **json_serializable** + **build_runner**: Tự động tạo code chuyển đổi JSON
- **flutter_dotenv**: Quản lý biến môi trường

## Local Storage

- **hive** + **hive_flutter**: Database NoSQL nhẹ và nhanh
- **shared_preferences**: Lưu trữ đơn giản cho settings

## Media Handling

- **image_picker**: Chọn ảnh/video từ gallery hoặc camera
- **multi_image_picker**: Chọn nhiều ảnh cùng lúc
- **cached_network_image**: Tối ưu việc tải và hiển thị ảnh
- **photo_view**: Xem ảnh với zoom và pan
- **video_player**: Phát video

## Livestream

- **tencent_trtc_cloud**: SDK chính cho livestream
- **tencent_im_sdk_plugin**: Chat trong livestream (nếu cần)

## UI/UX

- **flutter_native_splash**: Tạo splash screen
- **flutter_screenutil**: Responsive design
- **shimmer**: Loading effects
- **flutter_svg**: Hiển thị SVG icons
- **animations**: Animation cho UI
- **pull_to_refresh**: Refresh data với pull-down

## Navigation

- **go_router**: Navigation và deep linking

## Internationalization

- **flutter_localizations**: Package cơ bản cho đa ngôn ngữ
- **intl**: Hỗ trợ định dạng ngày, số, và strings

## Utils

- **permission_handler**: Xin quyền (vị trí, camera, mic)
- **logger**: Logging nâng cao
- **timeago**: Hiển thị thời gian tương đối (ví dụ: "3 phút trước")
- **url_launcher**: Mở URLs, emails, phone calls
- **connectivity_plus**: Kiểm tra kết nối internet
- **flutter_keyboard_visibility**: Quản lý hiển thị bàn phím
- **uuid**: Tạo IDs duy nhất

## Testing

- **bloc_test**: Test BLoCs
- **mockito**: Tạo mock objects cho testing
- **integration_test**: Testing tích hợp

## Thứ tự triển khai:

1. **Cơ sở dự án**: Cấu trúc thư mục, DI, theme, routing
2. **Splash Screen & Đa ngôn ngữ**: Setup ban đầu
3. **Authentication**: Đăng nhập, đăng ký với Firebase Auth
4. **Map & Location**: Tích hợp Mapbox, hiển thị vị trí
5. **Post Creation**: Tạo và hiển thị bài đăng trên bản đồ
6. **Livestream**: Tích hợp Tencent TRTC, quản lý phiên livestream

Danh sách này cung cấp các công nghệ cần thiết cho dự án "Thèm", trong đó đã cập nhật chuyển từ Google Maps sang Mapbox và thêm các thư viện cần thiết cho splash screen và đa ngôn ngữ.