import 'package:flutter/material.dart';
import 'home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _linkedinCtrl = TextEditingController();
  final TextEditingController _githubCtrl = TextEditingController();
  final TextEditingController _skillCtrl = TextEditingController();

  final List<String> _commonSkills = [
    "Full Stack Web Development",
    "React Native",
    "AIML",
    "BlockChain & Web3",
    "CyberSecurity",
    "UI/UX",
  ];

  final List<String> _selectedSkills = [];

  void _addSkill(String skill) {
    if (skill.isNotEmpty && !_selectedSkills.contains(skill)) {
      setState(() {
        _selectedSkills.add(skill);
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      _selectedSkills.remove(skill);
    });
  }

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      if (_currentStep < 3) {
        setState(() => _currentStep++);
      } else {
        // Final step -> go to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: // Name step
        return Column(
          children: [
            TextFormField(
              controller: _firstNameCtrl,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Enter your first name" : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _lastNameCtrl,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Enter your last name" : null,
            ),
          ],
        );

      case 1: // DOB step
        return TextFormField(
          controller: _dobCtrl,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: "Date of Birth",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: (value) =>
          value == null || value.isEmpty ? "Select your date of birth" : null,
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000, 1, 1),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              _dobCtrl.text =
              "${picked.day}/${picked.month}/${picked.year}";
            }
          },
        );

      case 2: // LinkedIn & GitHub
        return Column(
          children: [
            TextFormField(
              controller: _linkedinCtrl,
              decoration: const InputDecoration(
                labelText: "LinkedIn URL",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Enter LinkedIn URL" : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _githubCtrl,
              decoration: const InputDecoration(
                labelText: "GitHub URL",
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Enter GitHub URL" : null,
            ),
          ],
        );

      case 3: // Skills
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedSkills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Colors.green.shade400,
                  labelStyle: const TextStyle(color: Colors.white),
                  deleteIcon:
                  const Icon(Icons.close, size: 18, color: Colors.white),
                  onDeleted: () => _removeSkill(skill),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Popular skills:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: _commonSkills.map((skill) {
                return OutlinedButton(
                  onPressed: () => _addSkill(skill),
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Colors.black26),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("+ ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      Text(skill,
                          style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _skillCtrl,
                    decoration: InputDecoration(
                      hintText: "Add a new skill",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.black87,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      _addSkill(_skillCtrl.text.trim());
                      _skillCtrl.clear();
                    },
                  ),
                ),
              ],
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return "Set up your profile";
      case 1:
        return "Add your Date of Birth";
      case 2:
        return "Add your Socials";
      case 3:
        return "Add your Skills";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Text(
                  _getStepTitle(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildStepContent(),
                const Spacer(),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ).copyWith(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF3A5A), Color(0xFFFF7539)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          _currentStep < 3 ? "Next" : "Finish",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
