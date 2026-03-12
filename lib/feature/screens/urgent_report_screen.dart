import 'package:flutter/material.dart';
import 'package:n2n/data/model/urgent_report_model.dart';

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
                 onPressed: () {
  if (_formKey.currentState!.validate()) {
    // 1. Create the request object using the 10 required fields
    final reportRequest = UrgentHelpRequest(
      reporterName: _nameController.text.trim(),
      reporterPhone: _phoneController.text.trim(),
      reporterEmail: _emailController.text.trim(),
      subjectCategory: _categoryController.text.trim(),
      estimatedAge: _ageController.text.trim(),
      isLifeThreatening: _isLifeThreatening,
      description: _descriptionController.text.trim(),
      lat: _lat,  // Currently mocked as 22.3475
      long: _long, // Currently mocked as 91.8123
      landmark: _landmarkController.text.trim(),
    );

    // 2. Log it for debugging (to see the JSON structure in terminal)
    debugPrint("Submitting Report: ${reportRequest.toJson()}");

    // 3. Show a success message for now
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Emergency report sent for ${reportRequest.reporterName}"),
        backgroundColor: Colors.green,
      ),
    );
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