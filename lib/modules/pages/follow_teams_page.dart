import 'package:flutter/material.dart';
import 'package:sports_news_app/modules/pages/follow_Leagues%20_page.dart';

// Sport Type Enum
enum SportType { football, basketball, tennis, volleyball }

// Team Type Enum
enum TeamType { club, national }

// Team Model
class Team {
  final String id;
  final String name;
  final String country;
  final String logoEmoji;
  final TeamType type;
  final SportType sport;
  final String? league;
  final String? conference;
  bool isFollowing;

  Team({
    required this.id,
    required this.name,
    required this.country,
    required this.logoEmoji,
    required this.type,
    required this.sport,
    this.league,
    this.conference,
    this.isFollowing = false,
  });
}

class FollowTeamsPage extends StatefulWidget {
  const FollowTeamsPage({super.key});

  @override
  State<FollowTeamsPage> createState() => _FollowTeamsPageState();
}

class _FollowTeamsPageState extends State<FollowTeamsPage>
    with SingleTickerProviderStateMixin {
  static const Color primaryGreen = Color(0xFF43A047);
  static const Color darkGreen = Color(0xFF2E7D32);
  static const Color lightGreen = Color(0xFF81C784);

  static const Map<String, String> _teamLogoAssets = {
    'man_utd': 'assets/images/Manchester-United.png',
    'man_city': 'assets/images/manchester-city.png',
    'liverpool': 'assets/images/Liverpool.png',
    'chelsea': 'assets/images/Chelsea.png',
    'arsenal': 'assets/images/Arsenal.png',
    'tottenham': 'assets/images/Tottenham.png',
    'real_madrid': 'assets/images/Real-Madrid.png',
    'barcelona': 'assets/images/Barcelona.png',
    'atletico': 'assets/images/Atletico-Madrid.png',
    'bayern': 'assets/images/Bayern-Munchen.png',
    'dortmund': 'assets/images/Borussia-Dortmund.png',
    'rb_leipzig': 'assets/images/RB-Leipzig.png',
    'juventus': 'assets/images/Juventus.png',
    'ac_milan': 'assets/images/AC-Milan.png',
    'inter': 'assets/images/Inter-Milan.png',
    'psg': 'assets/images/Paris-saint-germain.png',
    'monaco': 'assets/images/AS-Monaco.png',
    'ajax': 'assets/images/Ajax.png',
    'porto': 'assets/images/FC-Porto.png',
    'benfica': 'assets/images/Benfica.png',
    'inter_miami': 'assets/images/Inter-Miami.png',
    'la_galaxy': 'assets/images/LA-Galaxy.png',
    'al_nassr': 'assets/images/AL-Nassr.png',
    'al_hilal': 'assets/images/AL-Hilal.png',
  };

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Team> _allTeams = [];
  Set<String> _followedTeamIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _initializeTeams();
  }

  Widget _buildTeamLogo(Team team, Color sportColor) {
    final assetPath = _teamLogoAssets[team.id];
    if (assetPath == null) {
      return Text(team.logoEmoji, style: const TextStyle(fontSize: 30));
    }

    return Image.asset(
      assetPath,
      width: 52,
      height: 52,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Text(team.logoEmoji, style: const TextStyle(fontSize: 30));
      },
    );
  }

  void _initializeTeams() {
    _allTeams = [
      // ==================== FOOTBALL TEAMS ====================
      // English Premier League
      Team(
        id: 'man_utd',
        name: 'Manchester United',
        country: 'England',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      Team(
        id: 'man_city',
        name: 'Manchester City',
        country: 'England',
        logoEmoji: '🩵',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      Team(
        id: 'liverpool',
        name: 'Liverpool',
        country: 'England',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      Team(
        id: 'chelsea',
        name: 'Chelsea',
        country: 'England',
        logoEmoji: '🔵',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      Team(
        id: 'arsenal',
        name: 'Arsenal',
        country: 'England',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      Team(
        id: 'tottenham',
        name: 'Tottenham Hotspur',
        country: 'England',
        logoEmoji: '⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Premier League',
      ),
      // La Liga
      Team(
        id: 'real_madrid',
        name: 'Real Madrid',
        country: 'Spain',
        logoEmoji: '⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'La Liga',
      ),
      Team(
        id: 'barcelona',
        name: 'FC Barcelona',
        country: 'Spain',
        logoEmoji: '🔵🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'La Liga',
      ),
      Team(
        id: 'atletico',
        name: 'Atlético Madrid',
        country: 'Spain',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'La Liga',
      ),
      // Bundesliga
      Team(
        id: 'bayern',
        name: 'Bayern Munich',
        country: 'Germany',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Bundesliga',
      ),
      Team(
        id: 'dortmund',
        name: 'Borussia Dortmund',
        country: 'Germany',
        logoEmoji: '🟡',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Bundesliga',
      ),
      Team(
        id: 'rb_leipzig',
        name: 'RB Leipzig',
        country: 'Germany',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Bundesliga',
      ),
      // Serie A
      Team(
        id: 'juventus',
        name: 'Juventus',
        country: 'Italy',
        logoEmoji: '⚫⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Serie A',
      ),
      Team(
        id: 'ac_milan',
        name: 'AC Milan',
        country: 'Italy',
        logoEmoji: '🔴⚫',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Serie A',
      ),
      Team(
        id: 'inter',
        name: 'Inter Milan',
        country: 'Italy',
        logoEmoji: '🔵⚫',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Serie A',
      ),
      Team(
        id: 'napoli',
        name: 'Napoli',
        country: 'Italy',
        logoEmoji: '🔵',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Serie A',
      ),
      // Ligue 1
      Team(
        id: 'psg',
        name: 'Paris Saint-Germain',
        country: 'France',
        logoEmoji: '🔵🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Ligue 1',
      ),
      Team(
        id: 'monaco',
        name: 'AS Monaco',
        country: 'France',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Ligue 1',
      ),
      // Other Leagues
      Team(
        id: 'ajax',
        name: 'Ajax Amsterdam',
        country: 'Netherlands',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Eredivisie',
      ),
      Team(
        id: 'porto',
        name: 'FC Porto',
        country: 'Portugal',
        logoEmoji: '🔵⚪',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Primeira Liga',
      ),
      Team(
        id: 'benfica',
        name: 'Benfica',
        country: 'Portugal',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Primeira Liga',
      ),
      // MLS
      Team(
        id: 'inter_miami',
        name: 'Inter Miami',
        country: 'USA',
        logoEmoji: '🩷',
        type: TeamType.club,
        sport: SportType.football,
        league: 'MLS',
      ),
      Team(
        id: 'la_galaxy',
        name: 'LA Galaxy',
        country: 'USA',
        logoEmoji: '🔵🟡',
        type: TeamType.club,
        sport: SportType.football,
        league: 'MLS',
      ),
      // Saudi Pro League
      Team(
        id: 'al_nassr',
        name: 'Al-Nassr',
        country: 'Saudi Arabia',
        logoEmoji: '🟡',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Saudi Pro League',
      ),
      Team(
        id: 'al_hilal',
        name: 'Al-Hilal',
        country: 'Saudi Arabia',
        logoEmoji: '🔵',
        type: TeamType.club,
        sport: SportType.football,
        league: 'Saudi Pro League',
      ),
      // Football National Teams
      Team(
        id: 'brazil_nt',
        name: 'Brazil',
        country: 'South America',
        logoEmoji: '🇧🇷',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'argentina_nt',
        name: 'Argentina',
        country: 'South America',
        logoEmoji: '🇦🇷',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'germany_nt',
        name: 'Germany',
        country: 'Europe',
        logoEmoji: '🇩🇪',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'france_nt',
        name: 'France',
        country: 'Europe',
        logoEmoji: '🇫🇷',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'spain_nt',
        name: 'Spain',
        country: 'Europe',
        logoEmoji: '🇪🇸',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'england_nt',
        name: 'England',
        country: 'Europe',
        logoEmoji: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'italy_nt',
        name: 'Italy',
        country: 'Europe',
        logoEmoji: '🇮🇹',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'portugal_nt',
        name: 'Portugal',
        country: 'Europe',
        logoEmoji: '🇵🇹',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'netherlands_nt',
        name: 'Netherlands',
        country: 'Europe',
        logoEmoji: '🇳🇱',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'belgium_nt',
        name: 'Belgium',
        country: 'Europe',
        logoEmoji: '🇧🇪',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'usa_nt',
        name: 'USA',
        country: 'North America',
        logoEmoji: '🇺🇸',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'mexico_nt',
        name: 'Mexico',
        country: 'North America',
        logoEmoji: '🇲🇽',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'japan_nt',
        name: 'Japan',
        country: 'Asia',
        logoEmoji: '🇯🇵',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'south_korea_nt',
        name: 'South Korea',
        country: 'Asia',
        logoEmoji: '🇰🇷',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'syria_nt',
        name: 'Syria',
        country: 'Asia',
        logoEmoji: '🇸🇾',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'palestine_nt',
        name: 'Palestine',
        country: 'Asia',
        logoEmoji: '🇵🇸',
        type: TeamType.national,
        sport: SportType.football,
      ),
      Team(
        id: 'nigeria_nt',
        name: 'Nigeria',
        country: 'Africa',
        logoEmoji: '🇳🇬',
        type: TeamType.national,
        sport: SportType.football,
      ),

      // ==================== BASKETBALL TEAMS ====================
      // NBA - Eastern Conference
      Team(
        id: 'celtics',
        name: 'Boston Celtics',
        country: 'USA',
        logoEmoji: '🍀',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'nets',
        name: 'Brooklyn Nets',
        country: 'USA',
        logoEmoji: '⚫⚪',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'knicks',
        name: 'New York Knicks',
        country: 'USA',
        logoEmoji: '🔵🟠',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: '76ers',
        name: 'Philadelphia 76ers',
        country: 'USA',
        logoEmoji: '🔵🔴',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'heat',
        name: 'Miami Heat',
        country: 'USA',
        logoEmoji: '🔥',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'bucks',
        name: 'Milwaukee Bucks',
        country: 'USA',
        logoEmoji: '🦌',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'bulls',
        name: 'Chicago Bulls',
        country: 'USA',
        logoEmoji: '🐂',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      Team(
        id: 'cavaliers',
        name: 'Cleveland Cavaliers',
        country: 'USA',
        logoEmoji: '🍷',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Eastern',
      ),
      // NBA - Western Conference
      Team(
        id: 'lakers',
        name: 'Los Angeles Lakers',
        country: 'USA',
        logoEmoji: '💜💛',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'clippers',
        name: 'LA Clippers',
        country: 'USA',
        logoEmoji: '🔵🔴',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'warriors',
        name: 'Golden State Warriors',
        country: 'USA',
        logoEmoji: '💙💛',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'suns',
        name: 'Phoenix Suns',
        country: 'USA',
        logoEmoji: '☀️',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'mavericks',
        name: 'Dallas Mavericks',
        country: 'USA',
        logoEmoji: '🐴',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'nuggets',
        name: 'Denver Nuggets',
        country: 'USA',
        logoEmoji: '⛏️',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'spurs',
        name: 'San Antonio Spurs',
        country: 'USA',
        logoEmoji: '⚫⚪',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'thunder',
        name: 'Oklahoma City Thunder',
        country: 'USA',
        logoEmoji: '⚡',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'timberwolves',
        name: 'Minnesota Timberwolves',
        country: 'USA',
        logoEmoji: '🐺',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      Team(
        id: 'grizzlies',
        name: 'Memphis Grizzlies',
        country: 'USA',
        logoEmoji: '🐻',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'NBA',
        conference: 'Western',
      ),
      // EuroLeague Teams
      Team(
        id: 'real_madrid_basket',
        name: 'Real Madrid Basketball',
        country: 'Spain',
        logoEmoji: '⚪',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'barcelona_basket',
        name: 'FC Barcelona Basketball',
        country: 'Spain',
        logoEmoji: '🔵🔴',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'olympiacos',
        name: 'Olympiacos BC',
        country: 'Greece',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'panathinaikos',
        name: 'Panathinaikos BC',
        country: 'Greece',
        logoEmoji: '💚',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'fenerbahce_basket',
        name: 'Fenerbahçe Basketball',
        country: 'Turkey',
        logoEmoji: '💙💛',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'cska_moscow',
        name: 'CSKA Moscow',
        country: 'Russia',
        logoEmoji: '🔴🔵',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      Team(
        id: 'maccabi_tel_aviv',
        name: 'Maccabi Tel Aviv',
        country: 'Israel',
        logoEmoji: '💛💙',
        type: TeamType.club,
        sport: SportType.basketball,
        league: 'EuroLeague',
      ),
      // Basketball National Teams
      Team(
        id: 'usa_basket_nt',
        name: 'USA Basketball',
        country: 'North America',
        logoEmoji: '🇺🇸',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'spain_basket_nt',
        name: 'Spain Basketball',
        country: 'Europe',
        logoEmoji: '🇪🇸',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'france_basket_nt',
        name: 'France Basketball',
        country: 'Europe',
        logoEmoji: '🇫🇷',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'serbia_basket_nt',
        name: 'Serbia Basketball',
        country: 'Europe',
        logoEmoji: '🇷🇸',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'germany_basket_nt',
        name: 'Germany Basketball',
        country: 'Europe',
        logoEmoji: '🇩🇪',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'greece_basket_nt',
        name: 'Greece Basketball',
        country: 'Europe',
        logoEmoji: '🇬🇷',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'australia_basket_nt',
        name: 'Australia Basketball',
        country: 'Oceania',
        logoEmoji: '🇦🇺',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'canada_basket_nt',
        name: 'Canada Basketball',
        country: 'North America',
        logoEmoji: '🇨🇦',
        type: TeamType.national,
        sport: SportType.basketball,
      ),
      Team(
        id: 'slovenia_basket_nt',
        name: 'Slovenia Basketball',
        country: 'Europe',
        logoEmoji: '🇸🇮',
        type: TeamType.national,
        sport: SportType.basketball,
      ),

      // ==================== TENNIS TEAMS (Davis Cup / BJK Cup) ====================
      Team(
        id: 'spain_tennis',
        name: 'Spain',
        country: 'Europe',
        logoEmoji: '🇪🇸',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'italy_tennis',
        name: 'Italy',
        country: 'Europe',
        logoEmoji: '🇮🇹',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'usa_tennis',
        name: 'USA',
        country: 'North America',
        logoEmoji: '🇺🇸',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'australia_tennis',
        name: 'Australia',
        country: 'Oceania',
        logoEmoji: '🇦🇺',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'france_tennis',
        name: 'France',
        country: 'Europe',
        logoEmoji: '🇫🇷',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'germany_tennis',
        name: 'Germany',
        country: 'Europe',
        logoEmoji: '🇩🇪',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'great_britain_tennis',
        name: 'Great Britain',
        country: 'Europe',
        logoEmoji: '🇬🇧',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'serbia_tennis',
        name: 'Serbia',
        country: 'Europe',
        logoEmoji: '🇷🇸',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'canada_tennis',
        name: 'Canada',
        country: 'North America',
        logoEmoji: '🇨🇦',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'argentina_tennis',
        name: 'Argentina',
        country: 'South America',
        logoEmoji: '🇦🇷',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'netherlands_tennis',
        name: 'Netherlands',
        country: 'Europe',
        logoEmoji: '🇳🇱',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'czech_tennis',
        name: 'Czech Republic',
        country: 'Europe',
        logoEmoji: '🇨🇿',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'poland_tennis',
        name: 'Poland',
        country: 'Europe',
        logoEmoji: '🇵🇱',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'japan_tennis',
        name: 'Japan',
        country: 'Asia',
        logoEmoji: '🇯🇵',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      Team(
        id: 'china_tennis',
        name: 'China',
        country: 'Asia',
        logoEmoji: '🇨🇳',
        type: TeamType.national,
        sport: SportType.tennis,
        league: 'Davis Cup / BJK Cup',
      ),
      // Laver Cup Teams
      Team(
        id: 'team_europe_tennis',
        name: 'Team Europe',
        country: 'Europe',
        logoEmoji: '🇪🇺',
        type: TeamType.club,
        sport: SportType.tennis,
        league: 'Laver Cup',
      ),
      Team(
        id: 'team_world_tennis',
        name: 'Team World',
        country: 'International',
        logoEmoji: '🌍',
        type: TeamType.club,
        sport: SportType.tennis,
        league: 'Laver Cup',
      ),

      // ==================== VOLLEYBALL TEAMS ====================
      // Italian Serie A
      Team(
        id: 'perugia_volley',
        name: 'Sir Safety Perugia',
        country: 'Italy',
        logoEmoji: '⚫🟡',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Serie A (Italy)',
      ),
      Team(
        id: 'modena_volley',
        name: 'Modena Volley',
        country: 'Italy',
        logoEmoji: '💙💛',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Serie A (Italy)',
      ),
      Team(
        id: 'trentino_volley',
        name: 'Trentino Volley',
        country: 'Italy',
        logoEmoji: '💙💛',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Serie A (Italy)',
      ),
      Team(
        id: 'lube_civitanova',
        name: 'Lube Civitanova',
        country: 'Italy',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Serie A (Italy)',
      ),
      Team(
        id: 'milano_volley',
        name: 'Allianz Milano',
        country: 'Italy',
        logoEmoji: '🔵⚪',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Serie A (Italy)',
      ),
      // Polish PlusLiga
      Team(
        id: 'zaksa_kedzierzyn',
        name: 'ZAKSA Kędzierzyn-Koźle',
        country: 'Poland',
        logoEmoji: '🔵🟡',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'PlusLiga (Poland)',
      ),
      Team(
        id: 'jastrzebski_wegiel',
        name: 'Jastrzębski Węgiel',
        country: 'Poland',
        logoEmoji: '🟠⚫',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'PlusLiga (Poland)',
      ),
      Team(
        id: 'resovia',
        name: 'Asseco Resovia',
        country: 'Poland',
        logoEmoji: '🔴⚪',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'PlusLiga (Poland)',
      ),
      Team(
        id: 'skra_belchatow',
        name: 'PGE Skra Bełchatów',
        country: 'Poland',
        logoEmoji: '🟡🔵',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'PlusLiga (Poland)',
      ),
      // Brazilian Superliga
      Team(
        id: 'sada_cruzeiro',
        name: 'Sada Cruzeiro',
        country: 'Brazil',
        logoEmoji: '🔵⚪',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Superliga (Brazil)',
      ),
      Team(
        id: 'minas_volei',
        name: 'Minas Tênis Clube',
        country: 'Brazil',
        logoEmoji: '🟢⚪',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Superliga (Brazil)',
      ),
      Team(
        id: 'funvic_taubate',
        name: 'Funvic Taubaté',
        country: 'Brazil',
        logoEmoji: '🔵🟡',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Superliga (Brazil)',
      ),
      // Turkish League
      Team(
        id: 'vakifbank',
        name: 'VakifBank Istanbul',
        country: 'Turkey',
        logoEmoji: '🟡',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Sultanlar Ligi (Turkey)',
      ),
      Team(
        id: 'eczacibasi',
        name: 'Eczacıbaşı Istanbul',
        country: 'Turkey',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Sultanlar Ligi (Turkey)',
      ),
      Team(
        id: 'fenerbahce_volley',
        name: 'Fenerbahçe Volleyball',
        country: 'Turkey',
        logoEmoji: '💙💛',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'Efeler Ligi (Turkey)',
      ),
      // Japanese V.League
      Team(
        id: 'suntory_sunbirds',
        name: 'Suntory Sunbirds',
        country: 'Japan',
        logoEmoji: '🔴',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'V.League (Japan)',
      ),
      Team(
        id: 'panasonic_panthers',
        name: 'Panasonic Panthers',
        country: 'Japan',
        logoEmoji: '🔵',
        type: TeamType.club,
        sport: SportType.volleyball,
        league: 'V.League (Japan)',
      ),
      // Volleyball National Teams
      Team(
        id: 'poland_volley_nt',
        name: 'Poland Volleyball',
        country: 'Europe',
        logoEmoji: '🇵🇱',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'italy_volley_nt',
        name: 'Italy Volleyball',
        country: 'Europe',
        logoEmoji: '🇮🇹',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'brazil_volley_nt',
        name: 'Brazil Volleyball',
        country: 'South America',
        logoEmoji: '🇧🇷',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'usa_volley_nt',
        name: 'USA Volleyball',
        country: 'North America',
        logoEmoji: '🇺🇸',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'france_volley_nt',
        name: 'France Volleyball',
        country: 'Europe',
        logoEmoji: '🇫🇷',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'japan_volley_nt',
        name: 'Japan Volleyball',
        country: 'Asia',
        logoEmoji: '🇯🇵',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'serbia_volley_nt',
        name: 'Serbia Volleyball',
        country: 'Europe',
        logoEmoji: '🇷🇸',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'china_volley_nt',
        name: 'China Volleyball',
        country: 'Asia',
        logoEmoji: '🇨🇳',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'turkey_volley_nt',
        name: 'Turkey Volleyball',
        country: 'Europe',
        logoEmoji: '🇹🇷',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
      Team(
        id: 'slovenia_volley_nt',
        name: 'Slovenia Volleyball',
        country: 'Europe',
        logoEmoji: '🇸🇮',
        type: TeamType.national,
        sport: SportType.volleyball,
      ),
    ];
  }

  List<Team> get _filteredTeams {
    if (_searchQuery.isEmpty) {
      return _allTeams;
    }
    return _allTeams.where((team) {
      return team.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          team.country.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (team.league?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          team.sport.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<Team> get _footballTeams =>
      _filteredTeams.where((t) => t.sport == SportType.football).toList();

  List<Team> get _basketballTeams =>
      _filteredTeams.where((t) => t.sport == SportType.basketball).toList();

  List<Team> get _tennisTeams =>
      _filteredTeams.where((t) => t.sport == SportType.tennis).toList();

  List<Team> get _volleyballTeams =>
      _filteredTeams.where((t) => t.sport == SportType.volleyball).toList();

  void _toggleFollow(Team team) {
    setState(() {
      if (_followedTeamIds.contains(team.id)) {
        _followedTeamIds.remove(team.id);
        team.isFollowing = false;
      } else {
        _followedTeamIds.add(team.id);
        team.isFollowing = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _buildResponsiveLayout(constraints, scheme);
          },
        ),
      ),
    );
  }

  Widget _buildResponsiveLayout(
    BoxConstraints constraints,
    ColorScheme scheme,
  ) {
    final width = constraints.maxWidth;
    final isDesktop = width > 1024;
    final isTablet = width > 600 && width <= 1024;

    if (isDesktop) {
      return _buildDesktopLayout(scheme);
    } else if (isTablet) {
      return _buildTabletLayout(scheme);
    } else {
      return _buildMobileLayout(scheme);
    }
  }

  // ==================== DESKTOP LAYOUT ====================
  Widget _buildDesktopLayout(ColorScheme scheme) {
    return Row(
      children: [
        _buildDesktopSidebar(scheme),
        Expanded(
          child: Column(
            children: [
              _buildDesktopHeader(scheme),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: _buildMainContent(scheme, isDesktop: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopSidebar(ColorScheme scheme) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'SportsFeed',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          // Onboarding Progress
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setup Progress',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _buildProgressItem('Choose Sports', true, 1, scheme: scheme),
                _buildProgressItem('Select Leagues', true, 2, scheme: scheme),
                _buildProgressItem(
                  'Follow Teams',
                  false,
                  3,
                  isActive: true,
                  scheme: scheme,
                ),
                _buildProgressItem('Follow Players', false, 4, scheme: scheme),
              ],
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          // Sports Quick Stats
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Following by Sport',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSportStatRow(
                  Icons.sports_soccer,
                  'Football',
                  _footballTeams
                      .where((t) => _followedTeamIds.contains(t.id))
                      .length,
                  _footballTeams.length,
                  _getSportColor(SportType.football),
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_basketball,
                  'Basketball',
                  _basketballTeams
                      .where((t) => _followedTeamIds.contains(t.id))
                      .length,
                  _basketballTeams.length,
                  _getSportColor(SportType.basketball),
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_tennis,
                  'Tennis',
                  _tennisTeams
                      .where((t) => _followedTeamIds.contains(t.id))
                      .length,
                  _tennisTeams.length,
                  _getSportColor(SportType.tennis),
                  scheme: scheme,
                ),
                _buildSportStatRow(
                  Icons.sports_volleyball,
                  'Volleyball',
                  _volleyballTeams
                      .where((t) => _followedTeamIds.contains(t.id))
                      .length,
                  _volleyballTeams.length,
                  _getSportColor(SportType.volleyball),
                  scheme: scheme,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Following Summary
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryGreen.withOpacity(0.1),
                  lightGreen.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: lightGreen.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(Icons.groups_outlined, color: primaryGreen, size: 40),
                const SizedBox(height: 12),
                Text(
                  '${_followedTeamIds.length}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
                Text(
                  'Teams Following',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSportStatRow(
    IconData icon,
    String sport,
    int following,
    int total,
    Color color, {
    required ColorScheme scheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sport,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: scheme.onSurface,
                  ),
                ),
                Text(
                  '$following of $total',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: following > 0
                  ? color.withOpacity(0.1)
                  : scheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$following',
              style: TextStyle(
                color: following > 0 ? color : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
    String title,
    bool isCompleted,
    int step, {
    bool isActive = false,
    required ColorScheme scheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isCompleted
                  ? primaryGreen
                  : isActive
                  ? primaryGreen.withOpacity(0.2)
                  : scheme.surfaceVariant,
              shape: BoxShape.circle,
              border: isActive
                  ? Border.all(color: primaryGreen, width: 2)
                  : null,
            ),
            child: Center(
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '$step',
                      style: TextStyle(
                        color: isActive
                            ? primaryGreen
                            : scheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? primaryGreen : scheme.onSurfaceVariant,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Current',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _buildSearchBar(scheme, isDesktop: true)),
          const SizedBox(width: 24),
          _buildFollowingChip(scheme),
          const SizedBox(width: 16),
          _buildContinueButton(scheme),
        ],
      ),
    );
  }

  // ==================== TABLET LAYOUT ====================
  Widget _buildTabletLayout(ColorScheme scheme) {
    return Column(
      children: [
        _buildMobileHeader(scheme),
        _buildSearchBar(scheme, isDesktop: false),
        _buildTabBar(scheme),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildTabContent(scheme),
          ),
        ),
        _buildBottomBar(scheme),
      ],
    );
  }

  // ==================== MOBILE LAYOUT ====================
  Widget _buildMobileLayout(ColorScheme scheme) {
    return Column(
      children: [
        _buildMobileHeader(scheme),
        _buildSearchBar(scheme, isDesktop: false),
        _buildTabBar(scheme),
        Expanded(child: _buildTabContent(scheme)),
        _buildBottomBar(scheme),
      ],
    );
  }

  Widget _buildMobileHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: scheme.onSurface),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Teams',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              _buildFollowingChip(scheme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ColorScheme scheme, {required bool isDesktop}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 0 : 20,
        vertical: isDesktop ? 0 : 16,
      ),
      color: isDesktop ? Colors.transparent : scheme.surface,
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search teams, countries, or leagues...',
            hintStyle: TextStyle(color: scheme.onSurfaceVariant),
            prefixIcon: Icon(Icons.search, color: scheme.onSurfaceVariant),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: scheme.onSurfaceVariant),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFollowingChip(ColorScheme scheme) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _followedTeamIds.isNotEmpty
            ? primaryGreen.withOpacity(0.1)
            : scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _followedTeamIds.isNotEmpty
              ? primaryGreen.withOpacity(0.3)
              : scheme.outline,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _followedTeamIds.isNotEmpty
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: _followedTeamIds.isNotEmpty
                ? primaryGreen
                : scheme.onSurfaceVariant,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            '${_followedTeamIds.length} Following',
            style: TextStyle(
              color: _followedTeamIds.isNotEmpty
                  ? primaryGreen
                  : scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton(ColorScheme scheme) {
    return ElevatedButton(
      onPressed: _followedTeamIds.isNotEmpty
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FollowLeaguesPage(),
                ),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: scheme.surfaceVariant,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Continue',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, size: 20),
        ],
      ),
    );
  }

  Widget _buildTabBar(ColorScheme scheme) {
    return Container(
      color: scheme.surface,
      child: TabBar(
        controller: _tabController,
        labelColor: primaryGreen,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: primaryGreen,
        indicatorWeight: 3,
        isScrollable: true,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        tabAlignment: TabAlignment.start,
        tabs: [
          _buildTabItem(Icons.sports, 'All', _filteredTeams.length, scheme),
          _buildTabItem(
            Icons.sports_soccer,
            'Football',
            _footballTeams.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_basketball,
            'Basketball',
            _basketballTeams.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_tennis,
            'Tennis',
            _tennisTeams.length,
            scheme,
          ),
          _buildTabItem(
            Icons.sports_volleyball,
            'Volleyball',
            _volleyballTeams.length,
            scheme,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    IconData icon,
    String label,
    int count,
    ColorScheme scheme,
  ) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
          if (count > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(fontSize: 12, color: scheme.onSurface),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent(ColorScheme scheme, {required bool isDesktop}) {
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.groups_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Follow Your Favorite Teams',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Select teams from any sport to get personalized updates',
                        style: TextStyle(
                          fontSize: 14,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: scheme.onSurfaceVariant,
                  indicator: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                  padding: const EdgeInsets.all(4),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: '⚽ Football'),
                    Tab(text: '🏀 Basketball'),
                    Tab(text: '🎾 Tennis'),
                    Tab(text: '🏐 Volleyball'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTeamsList(_filteredTeams, scheme, isDesktop: isDesktop),
                _buildTeamsList(_footballTeams, scheme, isDesktop: isDesktop),
                _buildTeamsList(_basketballTeams, scheme, isDesktop: isDesktop),
                _buildTeamsList(_tennisTeams, scheme, isDesktop: isDesktop),
                _buildTeamsList(_volleyballTeams, scheme, isDesktop: isDesktop),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(ColorScheme scheme) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTeamsGrid(_filteredTeams, scheme),
        _buildTeamsGrid(_footballTeams, scheme),
        _buildTeamsGrid(_basketballTeams, scheme),
        _buildTeamsGrid(_tennisTeams, scheme),
        _buildTeamsGrid(_volleyballTeams, scheme),
      ],
    );
  }

  Widget _buildTeamsList(
    List<Team> teams,
    ColorScheme scheme, {
    required bool isDesktop,
  }) {
    if (teams.isEmpty) {
      return _buildEmptyState(scheme);
    }

    // Group teams by league/country
    Map<String, List<Team>> groupedTeams = {};
    for (var team in teams) {
      String key = team.league ?? team.country;
      groupedTeams.putIfAbsent(key, () => []).add(team);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: groupedTeams.length,
      itemBuilder: (context, index) {
        String groupName = groupedTeams.keys.elementAt(index);
        List<Team> groupTeams = groupedTeams[groupName]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0) const SizedBox(height: 24),
            // Section Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getSportColor(
                        groupTeams.first.sport,
                      ).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getSportIcon(groupTeams.first.sport),
                          size: 16,
                          color: _getSportColor(groupTeams.first.sport),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          groupName,
                          style: TextStyle(
                            color: _getSportColor(groupTeams.first.sport),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(height: 1, color: scheme.outlineVariant),
                  ),
                ],
              ),
            ),
            // Teams Grid
            if (isDesktop)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: groupTeams.map((team) {
                  return SizedBox(
                    width: 340,
                    child: _buildTeamCard(team, scheme),
                  );
                }).toList(),
              )
            else
              ...groupTeams.map(
                (team) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildTeamCard(team, scheme),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTeamsGrid(List<Team> teams, ColorScheme scheme) {
    if (teams.isEmpty) {
      return _buildEmptyState(scheme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildTeamCard(teams[index], scheme),
        );
      },
    );
  }

  Widget _buildTeamCard(Team team, ColorScheme scheme) {
    final isFollowing = _followedTeamIds.contains(team.id);
    final sportColor = _getSportColor(team.sport);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFollowing ? sportColor : scheme.outlineVariant,
          width: isFollowing ? 2 : 1,
        ),
        boxShadow: isFollowing
            ? [
                BoxShadow(
                  color: sportColor.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleFollow(team),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Team Logo
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: sportColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: sportColor.withOpacity(0.3)),
                  ),
                  child: Center(child: _buildTeamLogo(team, sportColor)),
                ),
                const SizedBox(width: 16),
                // Team Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                team.name,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isFollowing
                                      ? sportColor
                                      : scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildSportBadge(team.sport, scheme),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            team.type == TeamType.club
                                ? Icons.location_on_outlined
                                : Icons.public,
                            size: 14,
                            color: scheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            team.country,
                            style: TextStyle(
                              fontSize: 13,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          if (team.league != null) ...[
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: scheme.onSurfaceVariant,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                team.league!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: scheme.onSurfaceVariant,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (team.conference != null) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${team.conference} Conference',
                            style: TextStyle(
                              fontSize: 11,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Follow Button
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: isFollowing
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: sportColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                'Following',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: sportColor, width: 1.5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: sportColor, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                'Follow',
                                style: TextStyle(
                                  color: sportColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSportBadge(SportType sport, ColorScheme scheme) {
    final color = _getSportColor(sport);
    final icon = _getSportIcon(sport);
    final name = _getSportName(sport);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme scheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: scheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off,
              size: 48,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No teams found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = '';
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear search'),
            style: TextButton.styleFrom(foregroundColor: primaryGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Skip button
            TextButton(
              onPressed: () {
                // Skip and continue
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            // Continue button
            ElevatedButton(
              onPressed: _followedTeamIds.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FollowLeaguesPage(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                disabledBackgroundColor: scheme.surfaceVariant,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _followedTeamIds.isEmpty
                        ? 'Select Teams'
                        : 'Continue (${_followedTeamIds.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Color _getSportColor(SportType sport) {
    switch (sport) {
      case SportType.football:
        return primaryGreen;
      case SportType.basketball:
        return Colors.orange[700]!;
      case SportType.tennis:
        return Colors.yellow[800]!;
      case SportType.volleyball:
        return Colors.blue[700]!;
    }
  }

  IconData _getSportIcon(SportType sport) {
    switch (sport) {
      case SportType.football:
        return Icons.sports_soccer;
      case SportType.basketball:
        return Icons.sports_basketball;
      case SportType.tennis:
        return Icons.sports_tennis;
      case SportType.volleyball:
        return Icons.sports_volleyball;
    }
  }

  String _getSportName(SportType sport) {
    switch (sport) {
      case SportType.football:
        return 'Football';
      case SportType.basketball:
        return 'Basketball';
      case SportType.tennis:
        return 'Tennis';
      case SportType.volleyball:
        return 'Volleyball';
    }
  }
}
