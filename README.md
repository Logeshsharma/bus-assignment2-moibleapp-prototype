# Mix&Match - Speed Friending App for University Freshers

Mix&Match is a mobile app prototype designed to support freshers and international students in overcoming common social, cultural, and academic challenges when entering university. The app creates dynamic peer groups, encourages group-based activities, and connects users with mentors to improve social integration and overall well-being.

## 📌 Project Overview

University life can be overwhelming, especially for international students. Mix&Match helps by:
- Forming diverse student groups automatically.
- Assigning mentors for guidance and support.
- Promoting group tasks and social events.
- Providing chat features (group and private).
- Encouraging participation with rewards.

This prototype focuses on demonstrating the foundational features of the platform with clean navigation and modular design.

## 🎯 Key Features

- 🔐 **Student Authentication**: Register/login using university credentials.
- 👥 **Group Formation**: Randomly assign students into groups of 5, ensuring diversity.
- 🎓 **Mentor Assignment**: Each group gets a mentor for guidance.
- 📆 **Event Management**: View events and participate in group activities.
- 🧩 **Task System**: Complete tasks, upload evidence, and receive rewards.
- 💬 **Chat System**: Group chat and private chat with mentors.
- 🔄 **Group Reassignment**: Request group changes if needed.

## 🛠️ Tech Stack - Mobile app

- **Prototype**: Flutter (Dart)
- **State Management:** GetX 
- **Target Platform:** Android (Prototype phase)

## 🛠️ How to Run the App

To run the prototype locally:

1. Clone the repository or unzip the folder.
2. Navigate to the project directory.
3. Run the following commands:

```bash
flutter pub get
flutter run
```

> ⚠️ Make sure you have Flutter SDK installed and your device/emulator is set up properly.

## 👤 Stakeholders

- **Students and Mentors :** Primary users for accessing resources and managing their university life.
- **University Staff:** Potential future role in backend support (not in prototype).
- **System Admin:** System monitoring.

## 📂 Project Structure

```
lib/
├── main.dart
├── module/
│   ├── home/
│   ├── tasks/
│   └── group/
```

Each module includes:
- `controller/` – Logic and state handling
- `presentation/` – UI components

## 👥 Team Members

- Arseniy Vasilko (2072309)
- Charlotte Ashmore (2897025)
- Gurjeevan Pannu (2897368)
- Logesh Sharma Kalimuthan (2845496)
- Mashrur Hossain Chowdhury Ritom (2867717)

Each team member contributed equally (20%).

## 📄 License

*This is a university prototype project. Not intended for commercial use.*