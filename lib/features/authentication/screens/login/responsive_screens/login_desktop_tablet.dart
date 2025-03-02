import 'package:flutter/material.dart';
import 'package:pine_admin_panel/common/styles/spacing_styles.dart';
import 'package:pine_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:pine_admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:pine_admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:pine_admin_panel/utils/constants/colors.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const PLoginTemplate(
        child: Column(
        children: [
        // Header
        PLoginHeader(),

        // Form
        PLoginForm(),
        ],
      ),
    );
  }
}
