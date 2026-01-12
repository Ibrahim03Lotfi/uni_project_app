import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://172.20.10.5:8000/api';
  static String? token;

  static Future<Map<String, String>> get headers async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return headers;
  }

  // Admin Dashboard Stats
  static Future<Map<String, dynamic>> getAdminStats() async {
    final url = Uri.parse('$baseUrl/admin/stats');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load admin stats: ${response.body}');
    }
  }

  // Admin: Get My Posts
  static Future<List<dynamic>> getMyPosts() async {
    final url = Uri.parse('$baseUrl/posts/mine');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load admin posts: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  
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

  static Future<Map<String, dynamic>> adminLogin({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/admin/login');
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
      throw Exception('Failed to login as admin');
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
      final decoded = json.decode(response.body);
      if (decoded is Map<String, dynamic> && decoded['data'] is Map<String, dynamic>) {
        return decoded['data'] as Map<String, dynamic>;
      }
      return decoded as Map<String, dynamic>;
    } else {
      throw Exception('Failed to get user data');
    }
  }

  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
  }) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.put(
      url,
      headers: await headers,
      body: json.encode({'name': name, 'email': email}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  // Get all sports
  static Future<List<dynamic>> getSports() async {
    final url = Uri.parse('$baseUrl/sports');
    final response = await http.get(url, headers: await headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? []; // Extract data array from response
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

  // Save selected teams
  static Future<void> saveTeamsPreferences(List<int> teamIds) async {
    print('API: saveTeamsPreferences called with IDs: $teamIds');
    final url = Uri.parse('$baseUrl/preferences/teams');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'team_ids': teamIds}),
    );

    print('API: saveTeamsPreferences response status: ${response.statusCode}');
    print('API: saveTeamsPreferences response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to save teams preferences');
    }
  }

  // Save selected players
  static Future<void> savePlayersPreferences(List<int> playerIds) async {
    print('API: savePlayersPreferences called with IDs: $playerIds');
    final url = Uri.parse('$baseUrl/preferences/players');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'player_ids': playerIds}),
    );

    print('API: savePlayersPreferences response status: ${response.statusCode}');
    print('API: savePlayersPreferences response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to save players preferences');
    }
  }

  // Save selected leagues
  static Future<void> saveLeaguesPreferences(List<int> leagueIds) async {
    print('API: saveLeaguesPreferences called with IDs: $leagueIds');
    final url = Uri.parse('$baseUrl/preferences/leagues');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'league_ids': leagueIds}),
    );

    print('API: saveLeaguesPreferences response status: ${response.statusCode}');
    print('API: saveLeaguesPreferences response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to save leagues preferences');
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
      return data['data']; // Resource collection returns 'data' array
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

  // Create Match (Admin)
  static Future<Map<String, dynamic>> createMatch({
    required int homeTeamId,
    required int awayTeamId,
    required int leagueId,
    required int sportId,
    required String matchTime,
    required String status,
    int? homeScore,
    int? awayScore,
    String? liveMinute,
  }) async {
    final url = Uri.parse('$baseUrl/matches');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({
        'home_team_id': homeTeamId.toString(),
        'away_team_id': awayTeamId.toString(),
        'league_id': leagueId.toString(),
        'sport_id': sportId.toString(),
        'match_time': matchTime,
        'status': status,
        if (homeScore != null) 'home_score': homeScore,
        if (awayScore != null) 'away_score': awayScore,
        if (liveMinute != null) 'live_minute': liveMinute,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create match: ${response.body}');
    }
  }

  // Get Matches
  static Future<List<dynamic>> getMatches() async {
    final url = Uri.parse('$baseUrl/matches');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded is List) return decoded;
      if (decoded is Map<String, dynamic>) {
        final data = decoded['data'];
        if (data is List) return data;
      }
      return [];
    } else {
      throw Exception('Failed to load matches: ${response.body}');
    }
  }

  // Update Match (Admin)
  static Future<Map<String, dynamic>> updateMatch({
    required String matchId,
    String? status,
    int? homeScore,
    int? awayScore,
    String? liveMinute,
    String? matchTime,
    int? homeTeamId,
    int? awayTeamId,
    int? leagueId,
    int? sportId,
  }) async {
    final url = Uri.parse('$baseUrl/matches/$matchId');
    final payload = <String, dynamic>{
      if (homeTeamId != null) 'home_team_id': homeTeamId.toString(),
      if (awayTeamId != null) 'away_team_id': awayTeamId.toString(),
      if (leagueId != null) 'league_id': leagueId.toString(),
      if (sportId != null) 'sport_id': sportId.toString(),
      if (matchTime != null) 'match_time': matchTime,
      if (status != null) 'status': status,
      if (homeScore != null) 'home_score': homeScore,
      if (awayScore != null) 'away_score': awayScore,
      if (liveMinute != null) 'live_minute': liveMinute,
    };

    final h = await headers;

    bool isSuccess(http.Response r) {
      return r.statusCode == 200 || r.statusCode == 201 || r.statusCode == 204;
    }

    bool looksLikeHtml(http.Response r) {
      final ct = (r.headers['content-type'] ?? '').toLowerCase();
      if (ct.contains('text/html')) return true;
      final body = r.body.trimLeft();
      return body.startsWith('<!doctype html') || body.startsWith('<html');
    }

    Map<String, dynamic> decodeBody(http.Response r) {
      final body = r.body;
      if (body.trim().isEmpty) return <String, dynamic>{};
      final trimmed = body.trimLeft();
      if (!(trimmed.startsWith('{') || trimmed.startsWith('['))) {
        return <String, dynamic>{'raw': body};
      }
      final decoded = json.decode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {'data': decoded};
    }

    http.Response response;

    response = await http.patch(url, headers: h, body: json.encode(payload));
    if (isSuccess(response) && !looksLikeHtml(response)) {
      return decodeBody(response);
    }

    response = await http.put(url, headers: h, body: json.encode(payload));
    if (isSuccess(response) && !looksLikeHtml(response)) {
      return decodeBody(response);
    }

    response = await http.post(
      url,
      headers: h,
      body: json.encode({...payload, '_method': 'PUT'}),
    );
    if (isSuccess(response) && !looksLikeHtml(response)) {
      return decodeBody(response);
    }

    throw Exception(
      'Failed to update match (${response.statusCode}): ${response.body}',
    );
  }

  // Delete Match (Admin)
  static Future<void> deleteMatch(String matchId) async {
    final url = Uri.parse('$baseUrl/matches/$matchId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    }
    throw Exception('Failed to delete match: ${response.body}');
  }

  // Search Posts
  static Future<List<dynamic>> searchPosts(String keyword) async {
    final url = Uri.parse('$baseUrl/posts/search?keyword=$keyword');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']; // Resource collection returns 'data' array
    } else {
      throw Exception('Failed to search posts');
    }
  }

  // Get user profile with role information
  static Future<Map<String, dynamic>> getUserProfile() async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user profile');
    }
  }

  // Get leagues by sport
  static Future<List<dynamic>> getLeaguesBySport(int sportId) async {
    final url = Uri.parse('$baseUrl/sports/$sportId/leagues');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? []; // Extract data array from response
    } else {
      throw Exception('Failed to load leagues');
    }
  }

  // Get teams by league
  static Future<List<dynamic>> getTeamsByLeague(int leagueId) async {
    final url = Uri.parse('$baseUrl/leagues/$leagueId/teams');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? []; // Extract data array from response
    } else {
      throw Exception('Failed to load teams');
    }
  }

  // Toggle like on a post
  static Future<Map<String, dynamic>> toggleLike(int articleId) async {
    final url = Uri.parse('$baseUrl/posts/$articleId/like');
    final response = await http.post(url, headers: await headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to toggle like');
    }
  }

  // Save all preferences at once
  static Future<Map<String, dynamic>> saveAllPreferences({
    List<int>? sportIds,
    List<int>? teamIds,
  }) async {
    final url = Uri.parse('$baseUrl/preferences');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({
        if (sportIds != null) 'sport_ids': sportIds,
        if (teamIds != null) 'team_ids': teamIds,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to save preferences');
    }
  }

  // Super Admin: Create admin
  static Future<Map<String, dynamic>> createAdmin({
    required String name,
    required String email,
    required String password,
    required int assignedSportId,
  }) async {
    final url = Uri.parse('$baseUrl/admin/admins');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'assigned_sport_id': assignedSportId,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create admin');
    }
  }

  // Super Admin: Get all users
  static Future<Map<String, dynamic>> getAllUsers() async {
    final url = Uri.parse('$baseUrl/admin/users');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Super Admin: Delete user
  static Future<void> deleteUser(int userId) async {
    final url = Uri.parse('$baseUrl/admin/users/$userId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  // Super Admin: Get sports for assignment
  static Future<List<dynamic>> getSportsForAssignment() async {
    final url = Uri.parse('$baseUrl/admin/sports/assignment');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? []; // Extract data array from response
    } else {
      throw Exception('Failed to load sports for assignment');
    }
  }

  // Get all leagues for recommendations
  static Future<List<dynamic>> getAllLeagues() async {
    final url = Uri.parse('$baseUrl/leagues');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load all leagues');
    }
  }

  // Get all teams for recommendations
  static Future<List<dynamic>> getAllTeams() async {
    final url = Uri.parse('$baseUrl/teams');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load all teams');
    }
  }

  // Get all players for recommendations
  static Future<List<dynamic>> getAllPlayers() async {
    final url = Uri.parse('$baseUrl/players');
    final response = await http.get(url, headers: await headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to load all players');
    }
  }

  // Follow/Unfollow methods
  static Future<void> followSport(int sportId) async {
    final url = Uri.parse('$baseUrl/user/preferences/sports');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'sport_ids': [sportId]}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow sport');
    }
  }

  static Future<void> unfollowSport(int sportId) async {
    final url = Uri.parse('$baseUrl/user/preferences/sports/$sportId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow sport');
    }
  }

  static Future<void> followLeague(int leagueId) async {
    final url = Uri.parse('$baseUrl/user/preferences/leagues');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'league_ids': [leagueId]}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow league');
    }
  }

  static Future<void> unfollowLeague(int leagueId) async {
    final url = Uri.parse('$baseUrl/user/preferences/leagues/$leagueId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow league');
    }
  }

  static Future<void> followTeam(int teamId) async {
    final url = Uri.parse('$baseUrl/user/preferences/teams');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'team_ids': [teamId]}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow team');
    }
  }

  static Future<void> unfollowTeam(int teamId) async {
    final url = Uri.parse('$baseUrl/user/preferences/teams/$teamId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow team');
    }
  }

  static Future<void> followPlayer(int playerId) async {
    final url = Uri.parse('$baseUrl/user/preferences/players');
    final response = await http.post(
      url,
      headers: await headers,
      body: json.encode({'player_ids': [playerId]}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to follow player');
    }
  }

  static Future<void> unfollowPlayer(int playerId) async {
    final url = Uri.parse('$baseUrl/user/preferences/players/$playerId');
    final response = await http.delete(url, headers: await headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to unfollow player');
    }
  }
}
