import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _actionNameController;
  late final TextEditingController _dataNameController;
  late final TextEditingController _categoryNameController;
  late final TextEditingController _packageNameController;
  late final TextEditingController _typeNameController;
  late final TextEditingController _argumentsNameController;

  @override
  void initState() {
    _actionNameController =
        TextEditingController(text: 'android.intent.action.VIEW');
    _dataNameController = TextEditingController(
        text:
            'https://app.dev.astech.com/order-detail/5a6c9428-75c2-44bd-b6ae-b582b26912b4');
    _categoryNameController =
        TextEditingController(text: 'android.intent.category.DEFAULT');
    _packageNameController = TextEditingController(text: 'app.dev.astech.com');
    _typeNameController = TextEditingController();
    _argumentsNameController = TextEditingController(text: '{}');

    super.initState();
  }

  @override
  void dispose() {
    _actionNameController.dispose();
    _dataNameController.dispose();
    _categoryNameController.dispose();
    _packageNameController.dispose();
    _typeNameController.dispose();
    _argumentsNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: _actionNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter action name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dataNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter data name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter category name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _packageNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter package name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _typeNameController,
                decoration: const InputDecoration(
                  labelText: 'Enter type name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _argumentsNameController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Enter arguments name',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => launchIntent(context),
                child: const Text('Launch Intent'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchIntent(BuildContext context) async {
    try {
      // launch intent
      if (Platform.isAndroid) {
        AndroidIntent intent = AndroidIntent(
          action: _actionNameController.text.isNotEmpty
              ? _actionNameController.text
              : null,
          data: _dataNameController.text.isNotEmpty
              ? _dataNameController.text
              : null,
          category: _categoryNameController.text,
          package: _packageNameController.text.isNotEmpty
              ? _packageNameController.text
              : null,
          type: _typeNameController.text.isNotEmpty
              ? _typeNameController.text
              : null,
          arguments: _argumentsNameController.text.isNotEmpty
              ? jsonDecode(_argumentsNameController.text)
              : null,
        );
        await intent.launch();
      }
    } catch (e, s) {
      log('Error launching intent', name: 'DebugLog', error: e, stackTrace: s);
      await showDialog(
        context: context,
        builder: (dCtx) => AlertDialog(
            title: const Text('Error launching intent'),
            content: SingleChildScrollView(child: Text('Error: $e\n$s')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dCtx),
                child: const Text('OK'),
              ),
            ]),
      );
    }
  }
}
