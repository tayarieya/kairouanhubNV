import 'package:flutter/material.dart';
import '../../pages/user_account_page.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Reuse existing UserAccountPage content but wrapped if needed
    return const UserAccountPage();
  }
}
