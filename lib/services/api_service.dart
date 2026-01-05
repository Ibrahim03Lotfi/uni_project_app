import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
 static const String baseUrl = 'http://172.20.10.5:8000/api';
  static String? token;

  static Future<Map<String, String>> get headers async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? bio,
  }) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'phone': phone,
        'bio': bio,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      token = data['token'];
      return data;
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      token = data['token'];
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  static Future<void> logout() async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.post(
      url,
      headers: await headers,
    );

    if (response.statusCode == 200) {
      token = null;
    } else {
      throw Exception('Logout failed');
    }
  }

  static Future<Map<String, dynamic>> getUser() async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(
      url,
      headers: await headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user data');
    }
  }


// Get all sports
static Future<List<dynamic>> getSports() async {
  final url = Uri.parse('$baseUrl/sports');
  final response = await http.get(url, headers: await headers);
  if (response.statusCode == 200) {
    return json.decode(response.body)['data'];
  } else {
    throw Exception('Failed to load sports');
  }
}

// Save selected sports
static Future<void> saveSportsPreferences(List<int> sportIds) async {
  final url = Uri.parse('$baseUrl/preferences/sports');
  final response = await http.post(
    url,
    headers: await headers,
    body: json.encode({'sport_ids': sportIds}),
  );
  
  if (response.statusCode != 200) {
    throw Exception('Failed to save sports preferences');
  }
}

// Get user's selected sports
static Future<List<dynamic>> getUserSports() async {
  final url = Uri.parse('$baseUrl/preferences');
  final response = await http.get(url, headers: await headers);
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['sports'];
  } else {
    throw Exception('Failed to load user preferences');
  }
}


// Add these methods to ApiService class



// Save user preferences
static Future<void> savePreferences(Map<String, dynamic> preferences) async {
  final url = Uri.parse('$baseUrl/user/preferences');
  final response = await http.post(
    url,
    headers: await headers,
    body: json.encode(preferences),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to save preferences');
  }
}

// Get user preferences
static Future<Map<String, dynamic>> getUserPreferences() async {
  final url = Uri.parse('$baseUrl/user/preferences');
  final response = await http.get(url, headers: await headers);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load preferences');
  }
}
}