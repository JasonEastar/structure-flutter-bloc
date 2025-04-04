// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:them/app/cubit/locale_cubit.dart';

class AsideMenu extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback? onToggle;
  final VoidCallback? onClose;
  final int selectedIndex;
  final Function(int)? onItemSelected;

  const AsideMenu({
    Key? key,
    this.isExpanded = true,
    this.onToggle,
    this.onClose,
    this.selectedIndex = 0,
    this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final menuWidth = isExpanded ? 280.0 : 80.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: menuWidth,
      height: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chỉ áp dụng SafeArea cho header
          // Header with logo and toggle button
          SafeArea(
            bottom: false, // Chỉ áp dụng cho phần trên
            child: _buildHeader(theme, isDarkMode),
          ),

          // Main menu
          Expanded(
            child: _buildMenu(context, theme, isDarkMode),
          ),

          // Divider before footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: theme.dividerColor.withOpacity(0.5)),
          ),

          // Footer with user profile
          // _buildFooter(theme, isDarkMode),
          SafeArea(
            top: false, // Chỉ áp dụng cho phần trên
            child: _buildFooter(theme, isDarkMode),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDarkMode) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and app name
          if (isExpanded)
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        theme.primaryColor,
                        theme.primaryColor.withBlue(
                            (theme.primaryColor.blue + 40).clamp(0, 255)),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'T',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Thèm',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            )
          else
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor,
                    theme.primaryColor
                        .withBlue((theme.primaryColor.blue + 40).clamp(0, 255)),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Text(
                  'T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

          // Toggle button with subtle hover effect
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: onToggle,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: theme.primaryColor.withOpacity(0.1),
                ),
                child: Icon(
                  isExpanded ? Icons.chevron_left : Icons.chevron_right,
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, ThemeData theme, bool isDarkMode) {
    // Define menu items
    final menuItems = [
      MenuItemData(
        icon: Icons.home_rounded,
        title: 'Trang chủ',
        index: 0,
      ),
      MenuItemData(
        icon: Icons.map_rounded,
        title: 'Bản đồ',
        index: 1,
      ),
      MenuItemData(
        icon: Icons.live_tv_rounded,
        title: 'Livestream',
        index: 2,
      ),
      MenuItemData(
        icon: Icons.language_rounded,
        title: 'Ngôn ngữ',
        index: 3,
        onTap: () => _showLanguageDialog(context),
      ),
      MenuItemData(
        icon: Icons.settings_rounded,
        title: 'Cài đặt',
        index: 4,
      ),
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        final isSelected = selectedIndex == item.index;

        return _buildMenuItem(
          context,
          icon: item.icon,
          title: item.title,
          isExpanded: isExpanded,
          isSelected: isSelected,
          onTap: item.onTap ??
              () {
                if (onItemSelected != null) {
                  onItemSelected!(item.index);
                }
              },
          isDarkMode: isDarkMode,
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    bool isSelected = false,
    bool isDarkMode = false,
  }) {
    final theme = Theme.of(context);

    // Calculate background color based on selection state
    final bgColor = isSelected
        ? theme.primaryColor.withOpacity(isDarkMode ? 0.2 : 0.1)
        : Colors.transparent;

    // Calculate text and icon color based on selection and theme
    final contentColor = isSelected
        ? theme.primaryColor
        : isDarkMode
            ? Colors.white70
            : Colors.black54;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? 16.0 : 8.0,
        vertical: 4.0,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: theme.primaryColor.withOpacity(0.1),
          highlightColor: theme.primaryColor.withOpacity(0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: 48,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isExpanded ? 16.0 : 0,
            ),
            child: Row(
              mainAxisAlignment: isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                // Icon with subtle animation
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.primaryColor.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: contentColor,
                    size: 22,
                  ),
                ),

                // Title with animated width
                if (isExpanded) ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: contentColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Show a subtle indicator for selected item
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.primaryColor,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: isExpanded
          ? Row(
              children: [
                // User avatar with border
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // User info with better typography
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tên người dùng',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'user@example.com',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white60 : Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Menu button for user actions
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: isDarkMode ? Colors.white60 : Colors.black54,
                    size: 20,
                  ),
                  onPressed: () {
                    // Show user menu
                  },
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Just show avatar in collapsed mode
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/1.jpg',
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          backgroundColor: isDarkMode ? Color(0xFF252525) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Chọn ngôn ngữ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                // Language options
                _buildLanguageOption(
                  context: context,
                  languageCode: 'en',
                  name: 'English',
                  flagEmoji: '🇺🇸',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 8),
                _buildLanguageOption(
                  context: context,
                  languageCode: 'vi',
                  name: 'Tiếng Việt',
                  flagEmoji: '🇻🇳',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 16),
                // Cancel button
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    backgroundColor:
                        isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageCode,
    required String name,
    required String flagEmoji,
    required bool isDarkMode,
  }) {
    final theme = Theme.of(context);
    final isSelected =
        context.read<LocaleCubit>().state.language.languageCode == languageCode;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context.read<LocaleCubit>().changeLocale(languageCode);
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.primaryColor.withOpacity(isDarkMode ? 0.2 : 0.1)
                : isDarkMode
                    ? Colors.grey[800]!.withOpacity(0.3)
                    : Colors.grey[100]!,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.primaryColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Flag emoji
              Text(
                flagEmoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              // Language name
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected
                      ? theme.primaryColor
                      : isDarkMode
                          ? Colors.white
                          : Colors.black87,
                ),
              ),
              const Spacer(),
              // Check icon for selected language
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: theme.primaryColor,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper class to organize menu items
class MenuItemData {
  final IconData icon;
  final String title;
  final int index;
  final VoidCallback? onTap;

  MenuItemData({
    required this.icon,
    required this.title,
    required this.index,
    this.onTap,
  });
}
