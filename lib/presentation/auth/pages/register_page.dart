import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_onlineshop_app/data/models/requests/register_request_model.dart';
import 'package:flutter_onlineshop_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_onlineshop_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_onlineshop_app/presentation/home/pages/home_page.dart';
// import 'package:flutter_onlineshop_app/presentation/auth/pages/login_page.dart';
import 'package:go_router/go_router.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/core.dart';
import '../../../core/router/app_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final rolesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    rolesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        children: [
          const Text(
            'Register Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, please complete the data below to register a new account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(30.0),
          const SpaceHeight(40.0),
          TextFormField(
            controller: nameController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.user.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email ID',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.email.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: phoneController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.home.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: rolesController,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Roles => USER',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.bag.svg(),
              ),
            ),
          ),
          const SpaceHeight(50.0),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (state) {
                  AuthLocalDatasource().saveAuthData(state); //menyimpan di lokal
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('REGISTER SUCCESS'), //menampilkan snackbar success
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.pushReplacement(
                      'dashboard'); // redirect page ke dashboard page
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(onPressed: () {
                    final dataRequest = RegisterRequestModel(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      roles: rolesController.text,
                    );

                    // print("Data Request: $dataRequest");

                    context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.register(dataRequest));

                    // Redirect to homepage after successful registration
                    context.goNamed(
                      RouteConstants.root,
                      pathParameters: {
                        'root_tab': '0'
                      }, // Sesuaikan dengan nilai yang sesuai
                    );



                  },
                    label:'REGISTER',
                  );
                },
                loading: () {
                  return const Center(
                    child:
                        CircularProgressIndicator(), //menjalankan widget circular progress indikator
                  );
                },
              );
            },
          ),
          const SpaceHeight(50.0),
          GestureDetector(
            onTap: () {
              // context.pushReplacement('login');
              // context.pushReplacement(RouteConstants.login);
              // context.goNamed(
              //   RouteConstants.root,
              //   pathParameters: PathParameters().toMap(),
              // );
              // context.pushReplacement(const LoginPage() as String);
              // context.pushReplacement(const LoginPage());
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LoginPage()),
              // );
              context.goNamed(RouteConstants.login);
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Already Account? ',
                    style: TextStyle(
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: 'Login Now',
                    style: TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
