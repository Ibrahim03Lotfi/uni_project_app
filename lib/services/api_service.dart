import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.8:8000/api';
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
      body: json.encode({'email': email, 'password': password}),
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
    final response = await http.post(url, headers: await headers);

    if (response.statusCode == 200) {
      token = null;
    } else {
      throw Exception('Logout failed');
    }
  }

  static Future<Map<String, dynamic>> getUser() async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(url, headers: await headers);

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

  // Get News Feed
  static Future<List<dynamic>> getNewsFeed() async {
    final url = Uri.parse('$baseUrl/feed');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; // Assuming paginate() returns a 'data' array
    } else {
      throw Exception('Failed to load news feed');
    }
  }

  // Create News Post (Admin)
  static Future<Map<String, dynamic>> createPost({
    required String title,
    required String description,
    required String content,
    required int sportId,
    required String category,
    int? teamId,
    String? imagePath,
  }) async {
    // Note: This uses multipart request for image upload
    final url = Uri.parse('$baseUrl/posts');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(await headers);

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['content'] = content;
    request.fields['sport_id'] = sportId.toString();
    request.fields['category'] = category;
    if (teamId != null) request.fields['team_id'] = teamId.toString();

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return json.decode(responseBody);
    } else {
      throw Exception('Failed to create post: $responseBody');
    }
  }

  // Search Posts
  static Future<List<dynamic>> searchPosts(String keyword) async {
    final url = Uri.parse('$baseUrl/posts/search?keyword=$keyword');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; // Assuming paginate() returns a 'data' array
    } else {
      throw Exception('Failed to search posts');
    }
  }
}
