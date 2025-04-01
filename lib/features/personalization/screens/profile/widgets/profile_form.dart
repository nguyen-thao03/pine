import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';
import 'package:pine_admin_panel/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;
    return Column(
      children: [
        PRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: PSizes.lg, horizontal: PSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thông tin tài khoản',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Form
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // First and Last Name
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'Họ',
                              label: Text('Họ'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) =>
                                PValidator.validateEmptyText('Họ', value),
                          ),
                        ),
                        const SizedBox(width: PSizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Tên',
                              label: Text('Tên'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) =>
                                PValidator.validateEmptyText('Tên', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PSizes.spaceBtwInputFields),

                    // Email and Phone
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false,
                            ),
                            initialValue: UserController.instance.user.value.email,
                          ),
                        ),
                        const SizedBox(width: PSizes.spaceBtwItems),
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Số điện thoại',
                              label: Text('Số điện thoại'),
                              prefixIcon: Icon(Iconsax.mobile),
                            ),
                            validator: (value) => PValidator.validateEmptyText(
                                'Số điện thoại', value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: PSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.loading.value ? () {} : controller.updateUserInformation(),
                    child: controller.loading.value
                        ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        : const Text('Cập nhật tài khoản'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
