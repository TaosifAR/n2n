import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:n2n/data/model/urgent_report_model.dart';


class ReportRepository {
  // This is a popular testing API that returns the sent data as a response
  final String _apiUrl = 'https://jsonplaceholder.typicode.com/posts'; 

  Future<bool> submitUrgentReport(UrgentHelpRequest request) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(request.toJson()), 
      );

      // JSONPlaceholder returns a 201 status code upon a successful POST request
      if (response.statusCode == 201) {
        print("Fake API Success: Data received on server!");
        print("Server Response: ${response.body}");
        return true;
      } else {
        print("Failed with status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error during submission: $e");
      return false;
    }
  }
}