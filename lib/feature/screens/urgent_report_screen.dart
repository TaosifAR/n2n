import 'package:flutter/material.dart';
import 'package:n2n/data/model/urgent_report_model.dart';
import 'package:n2n/data/repositories/report_repository.dart';

class UrgentReportScreen extends StatefulWidget {
  const UrgentReportScreen({super.key});

  @override
  State<UrgentReportScreen> createState() => _UrgentReportScreenState();
}

class _UrgentReportScreenState extends State<UrgentReportScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _categoryController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _landmarkController = TextEditingController();
  
  bool _isLifeThreatening = false;
  // Mocking Lat/Long for now (Requirement fields)
  double _lat = 22.3475; 
  double _long = 91.8123;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Urgent Help Request"),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reporter Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              
              _buildTextField(_nameController, "Full Name", Icons.person),
              _buildTextField(_phoneController, "Phone Number", Icons.phone, inputType: TextInputType.phone),
              _buildTextField(_emailController, "Email Address", Icons.email, inputType: TextInputType.emailAddress),
              
              const Divider(height: 40),
              const Text(
                "Incident Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              _buildTextField(_categoryController, "Subject Category (e.g. Accident)", Icons.category),
              _buildTextField(_ageController, "Estimated Age of Subject", Icons.calendar_today, inputType: TextInputType.number),
              _buildTextField(_landmarkController, "Nearby Landmark", Icons.location_on),
              _buildTextField(_descriptionController, "Description of Situation", Icons.description, maxLines: 3),

              const SizedBox(height: 10),
              
              // Life Threatening Switch
              Container(
                decoration: BoxDecoration(
                  color: _isLifeThreatening ? Colors.red.shade50 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SwitchListTile(
                  title: const Text("Is this life threatening?", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Toggle on if immediate medical attention is needed"),
                  value: _isLifeThreatening,
                  activeColor: Colors.red.shade700,
                  onChanged: (val) => setState(() => _isLifeThreatening = val),
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                 onPressed: () async {
  if (_formKey.currentState!.validate()) {
    // 1. Create the model object with the 10 required fields
    final report = UrgentHelpRequest(
      reporterName: _nameController.text,
      reporterPhone: _phoneController.text,
      reporterEmail: _emailController.text,
      subjectCategory: _categoryController.text,
      estimatedAge: _ageController.text,
      isLifeThreatening: _isLifeThreatening,
      description: _descriptionController.text,
      lat: 22.3475, // Temporarily hardcoded for now
      long: 91.8123, // Temporarily hardcoded for now
      landmark: _landmarkController.text,
    );

    // 2. Call the Repository to send data to the server
    final repo = ReportRepository();
    final success = await repo.submitUrgentReport(report);

    // 3. Provide feedback to the user
    if (!mounted) return; // Check if the widget is still in the tree
    
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success! Report sent to the fake server."),
          backgroundColor: Colors.green,
        ),
      );
      // Optional: Navigate back or clear the form here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error! Failed to send report."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("SUBMIT EMERGENCY REPORT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for clean code
  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType inputType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}