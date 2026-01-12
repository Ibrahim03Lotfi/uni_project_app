# Sports News App

A comprehensive sports news application built with Flutter (frontend) and Laravel (backend) that delivers personalized sports content to users based on their preferences.

## 🏗️ Architecture

This is a full-stack application consisting of:

- **Frontend**: Flutter mobile app for iOS, Android, Web, and Desktop
- **Backend**: Laravel API with SQLite database
- **Authentication**: Laravel Sanctum for token-based authentication

## ✨ Features

### User Features
- **Personalized News Feed**: Content based on user's preferred sports and teams
- **Multi-sport Coverage**: Football, basketball, tennis, and more
- **Search Functionality**: Find news articles by keywords
- **Dark/Light Mode**: Toggle between themes
- **Multi-language Support**: English (US/GB)
- **Responsive Design**: Works on all device sizes

### Admin Features
- **Role-based Access Control**: Super Admin, Sport Admin, and User roles
- **Content Management**: Create, edit, and publish news articles
- **Image Upload**: Add images to news articles
- **Sport-specific Administration**: Admins manage content for assigned sports only

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (>=3.9.0)
- PHP (>=8.2)
- Composer
- Node.js & npm (for backend assets)

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd sports_news_backend
   ```

2. **Install dependencies:**
   ```bash
   composer install
   ```

3. **Environment setup:**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

4. **Database setup:**
   ```bash
   php artisan migrate
   php artisan db:seed
   ```

5. **Start the server:**
   ```bash
   php artisan serve
   ```

   The API will be available at `http://localhost:8000`

### Frontend Setup

1. **Navigate to root directory:**
   ```bash
   # From the project root
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

   Available platforms:
   - `flutter run -d chrome` (Web)
   - `flutter run` (Default device)
   - `flutter run -d windows` (Windows Desktop)

## 🔐 Default Admin Accounts

After running the database seeders, you can use these accounts:

| Role | Email | Password | Access |
|------|-------|----------|---------|
| Super Admin | admin@app.com | password | Full system access |
| Football Admin | football_admin@app.com | password | Football content only |

## 📱 API Endpoints

### Authentication
- `POST /api/register` - User registration
- `POST /api/login` - User login
- `POST /api/logout` - User logout

### Sports Data
- `GET /api/sports` - Get all sports
- `GET /api/sports/{id}/leagues` - Get leagues for a sport
- `GET /api/leagues/{id}/teams` - Get teams for a league

### News Content
- `GET /api/feed` - Personalized news feed (authenticated)
- `GET /api/posts/search` - Search news articles
- `POST /api/posts` - Create news article (admin only)

### User Preferences
- `GET /api/preferences` - Get user preferences
- `POST /api/preferences` - Update user preferences

## 🗄️ Database Schema

### Core Tables
- **users**: User accounts with roles and preferences
- **sports**: Available sports categories
- **leagues**: Sports leagues and competitions
- **teams**: Team information
- **news_articles**: News articles with metadata
- **user_sports**: User sport preferences (pivot)
- **user_teams**: User team preferences (pivot)
- **article_likes**: Article likes and interactions

### User Roles
- `SUPER_ADMIN`: Full system access
- `ADMIN`: Sport-specific content management
- `USER`: Standard user access

## 🛠️ Tech Stack

### Frontend
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Material Design 3**: UI/UX design system
- **HTTP**: Network requests
- **Image Picker**: Image handling
- **Shared Preferences**: Local storage

### Backend
- **Laravel 12**: PHP framework
- **Laravel Sanctum**: API authentication
- **SQLite**: Database
- **Eloquent ORM**: Database operations
- **PHP 8.2**: Backend language

## 📁 Project Structure

```
sports_news_app/
├── lib/                          # Flutter app source
│   ├── core/                     # Core utilities and widgets
│   ├── data/                     # Data models and notifiers
│   ├── modules/                  # Feature modules
│   │   ├── Navbar/              # Navigation components
│   │   └── pages/               # App pages
│   ├── services/                # API services
│   └── main.dart               # App entry point
├── sports_news_backend/         # Laravel API
│   ├── app/
│   │   ├── Http/Controllers/    # API controllers
│   │   ├── Models/             # Eloquent models
│   │   └── Console/            # Console commands
│   ├── database/               # Database files
│   ├── routes/                 # API routes
│   └── config/                 # Configuration files
├── assets/images/              # Team logos and images
└── web/                       # Web build files
```

## 🔧 Development

### Running Tests
```bash
# Backend tests
cd sports_news_backend
php artisan test

# Flutter tests
flutter test
```

### Code Formatting
```bash
# Backend
cd sports_news_backend
composer run lint

# Flutter
flutter format .
```

### Adding New Sports
1. Add sport to database via seeder or migration
2. Add sport logo to `assets/images/`
3. Update frontend sport list if needed

## 🚀 Deployment

### Backend Production
1. Configure production database in `.env`
2. Set `APP_ENV=production` and `APP_DEBUG=false`
3. Run `php artisan config:cache`
4. Set up web server (Apache/Nginx)

### Frontend Production
```bash
# Build for web
flutter build web

# Build for mobile
flutter build apk
flutter build ios
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Troubleshooting

### Common Issues

**API Connection Error:**
- Ensure backend server is running on `http://localhost:8000`
- Check network permissions
- Verify API endpoints in `lib/services/api_service.dart`

**Database Issues:**
- Run `php artisan migrate:fresh --seed` to reset database
- Check SQLite file permissions
- Verify `.env` configuration

**Flutter Build Issues:**
- Run `flutter clean` then `flutter pub get`
- Check Flutter version compatibility
- Clear cache: `flutter pub cache repair`

## 📞 Support

For support and questions:
- Create an issue in the repository
- Check existing documentation
- Review API endpoints and database schema

---

Built with ❤️ using Flutter and Laravel
