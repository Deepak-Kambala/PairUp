import 'package:flutter/material.dart';
import 'home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _linkedinCtrl = TextEditingController();
  final TextEditingController _githubCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setup Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: "Name")),
              TextFormField(controller: _linkedinCtrl, decoration: const InputDecoration(labelText: "LinkedIn URL")),
              TextFormField(controller: _githubCtrl, decoration: const InputDecoration(labelText: "GitHub URL")),
              TextFormField(controller: _locationCtrl, decoration: const InputDecoration(labelText: "Location")),
              TextFormField(controller: _descCtrl, decoration: const InputDecoration(labelText: "Short Description")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) =>  HomeScreen()),
                    );
                  }
                },
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
