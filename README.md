# Employee CRUD App

This is a Flutter CRUD app for managing employees, built with local SQLite (Sqflite) database for offline storage. The app allows users to add, view, edit, and delete employee records with the following fields:
- Name
- Designation
- Salary
- Joining Date

## Features

- Add new employees
- View a list of all employees
- Edit employee details
- Delete employee records
- Local data storage using Sqflite (SQLite)

## Video Demonstration

Watch the video below for a complete walkthrough of the app's functionality:

[![Watch the Video](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://github.com/user-attachments/assets/c41f724e-fbf2-4b91-9db6-af7e3d8c3938
)


## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK
- An IDE like VSCode or Android Studio with Flutter and Dart plugins.

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/employee-crud-app.git
   cd employee-crud-app
   ```

2. Install the required dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

### Folder Structure

```bash
lib/
│
├── database_helper.dart   # Database helper for SQLite operations
├── employee_form.dart     # Form for adding and editing employees
├── employee_list.dart     # Page to display employee list and perform edit/delete actions
├── main.dart              # App entry point
```

## Database

- This app uses `Sqflite` for local SQLite database functionality.
- Database Version: 2
- Table: `employee`
- Columns:
  - `id`: Primary key (Auto Increment)
  - `name`: Text (Employee Name)
  - `designation`: Text (Employee Designation)
  - `salary`: Real (Employee Salary)
  - `joiningDate`: Text (Employee Joining Date)

## Dependencies

The following dependencies are used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.0.0
  path: ^1.8.0
  intl: ^0.17.0
```

## Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
