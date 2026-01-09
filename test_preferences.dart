import 'dart:convert';
import 'dart:io';

// Test script to debug the preference saving issue
void main() async {
  const baseUrl = 'http://localhost:8000/api';
  
  // Test user credentials (you'll need to replace with actual test user)
  const email = 'test@example.com';
  const password = 'password123';
  
  try {
    // 1. Login to get token
    print('1. Logging in...');
    final loginResponse = await HttpClient()
        .postUrl(Uri.parse('$baseUrl/login'))
        .then((request) {
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode({
        'email': email,
        'password': password,
      }));
      return request.close();
    }).then((response) async {
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final data = jsonDecode(responseBody);
        print('Login successful: ${data['token']}');
        return data['token'];
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    });
    
    final token = await loginResponse;
    
    // 2. Get user data to see current preferences
    print('\n2. Getting current user data...');
    final userResponse = await HttpClient()
        .getUrl(Uri.parse('$baseUrl/user'))
        .then((request) {
      request.headers.set('Authorization', 'Bearer $token');
      return request.close();
    }).then((response) async {
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final userData = jsonDecode(responseBody);
        print('Current user data: $userData');
        return userData;
      } else {
        throw Exception('Failed to get user: ${response.statusCode}');
      }
    });
    
    final userData = await userResponse;
    
    // 3. Save some sports preferences
    print('\n3. Saving sports preferences...');
    final saveResponse = await HttpClient()
        .postUrl(Uri.parse('$baseUrl/preferences/sports'))
        .then((request) {
      request.headers.contentType = ContentType.json;
      request.headers.set('Authorization', 'Bearer $token');
      request.write(jsonEncode({
        'sport_ids': [1, 2], // Save football and basketball
      }));
      return request.close();
    }).then((response) async {
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        print('Sports saved: $responseBody');
      } else {
        throw Exception('Failed to save sports: ${response.statusCode}');
      }
    });
    
    await saveResponse;
    
    // 4. Get user data again to see if preferences were saved
    print('\n4. Checking if preferences were saved...');
    final updatedUserResponse = await HttpClient()
        .getUrl(Uri.parse('$baseUrl/user'))
        .then((request) {
      request.headers.set('Authorization', 'Bearer $token');
      return request.close();
    }).then((response) async {
      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();
        final updatedUserData = jsonDecode(responseBody);
        print('Updated user data: $updatedUserData');
        
        // Check if preferences are present
        final preferredSports = updatedUserData['preferred_sports'];
        print('Preferred sports: $preferredSports');
        print('Number of preferred sports: ${preferredSports?.length ?? 0}');
        
        return updatedUserData;
      } else {
        throw Exception('Failed to get updated user: ${response.statusCode}');
      }
    });
    
    await updatedUserResponse;
    
  } catch (e) {
    print('Error: $e');
  }
}
