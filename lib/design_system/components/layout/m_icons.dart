// ============================================================
// GeniusLink Mobile — Icon Map
// File placement:  lib/design_system/components/layout/m_icons.dart
// ============================================================

import 'package:flutter/material.dart';

class MIcons {
  static const _map = <String, IconData>{
    'back': Icons.arrow_back_rounded,
    'chevR': Icons.chevron_right_rounded,
    'chevD': Icons.keyboard_arrow_down_rounded,
    'plus': Icons.add_rounded,
    'minus': Icons.remove_rounded,
    'check': Icons.check_rounded,
    'search': Icons.search_rounded,
    'searchO': Icons.search_rounded,
    'lock': Icons.lock_outline_rounded,
    'lockB': Icons.lock_rounded,
    'home': Icons.home_outlined,
    'ledger': Icons.menu_book_rounded,
    'store': Icons.storefront_outlined,
    'grid': Icons.grid_view_rounded,
    'bell': Icons.notifications_none_rounded,
    'bell2': Icons.notifications_none_rounded,
    'user': Icons.person_outline_rounded,
    'scan': Icons.qr_code_scanner_rounded,
    'trash': Icons.delete_outline_rounded,
    'download': Icons.download_rounded,
    'box': Icons.inventory_2_outlined,
    'cart': Icons.shopping_cart_outlined,
    'doc': Icons.description_outlined,
    'cloud': Icons.cloud_upload_outlined,
    'info': Icons.info_outline_rounded,
    'swap': Icons.swap_horiz_rounded,
    'calendar': Icons.calendar_today_rounded,
    'pin': Icons.location_on_outlined,
    'edit': Icons.edit_outlined,
    'settings': Icons.settings_outlined,
    'building': Icons.apartment_rounded,
    'globe': Icons.public_rounded,
    'percent': Icons.percent_rounded,
    'refresh': Icons.refresh_rounded,
    'mail': Icons.mail_outline_rounded,
    'card': Icons.credit_card_rounded,
    'link': Icons.link_rounded,
    'database': Icons.storage_rounded,
    'plug': Icons.power_outlined,
    'key': Icons.vpn_key_outlined,
    'switch2': Icons.sync_alt_rounded,
    'clock': Icons.schedule_rounded,
    'paperclip': Icons.attach_file_rounded,
    'briefcase': Icons.work_outline_rounded,
    'phone': Icons.phone_outlined,
    'alert': Icons.warning_amber_rounded,
    'inbox': Icons.inbox_rounded,
    'poll': Icons.poll_outlined,
    'send': Icons.send_rounded,
    'dots': Icons.more_horiz_rounded,
  };

  static IconData of(String name) => _map[name] ?? Icons.circle_outlined;
}
