import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/local_auth/local_auth_cubit.dart';
import '../logic/local_auth/local_auth_state.dart';
import 'home_screen.dart';

class LocalAuthScreen extends StatelessWidget {
  const LocalAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size * 1;
    return Scaffold(
      backgroundColor: const Color(0xff110E31),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Local Authorization",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  color: const Color(0xff1C183C),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Authorization",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Please use finger print of face id to login",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 60),
                  const Icon(
                    Icons.fingerprint,
                    color: Colors.green,
                    size: 80,
                  ),
                  const SizedBox(height: 60),
                  BlocConsumer<LocalAuthCubit, LocalAuthState>(
                    listener: (context, state) {
                      if (state is LocalAuthLoading) {
                        showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
                      }
                      if (state is LocalAuthSuccess) {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CupertinoButton.filled(
                        onPressed: () async {
                          context.read<LocalAuthCubit>().authenticate();
                        },
                        child: const Text("Authenticate"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
