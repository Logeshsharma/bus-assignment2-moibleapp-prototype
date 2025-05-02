# Mix&Match - Speed Friending App for University Freshers

Mix&Match is a mobile app prototype designed to support freshers and international students in overcoming common social, cultural, and academic challenges when entering university. The app creates dynamic peer groups, encourages group-based activities, and connects users with mentors to improve social integration and overall well-being.

## Project Overview - A brief description of the system and its purpose

University life can be overwhelming, especially for international students. Mix&Match helps by:
- Forming diverse student groups automatically.
- Assigning mentors for guidance and support.
- Promoting group tasks and social events.
- Providing chat features (group and private).
- Encouraging participation with rewards.

This prototype focuses on demonstrating the foundational features of the platform with clean navigation and modular design.


## Step-by-step instructions on how to run the project

> ⚠️ Prerequisites: Make sure you have Flutter SDK installed and your device/emulator is set up properly.

## Step 1: Install Flutter SDK

1. Download Flutter SDK from Flutter official site - [Flutter SDK Download](https://docs.flutter.dev/release/archive)

Follow platform-specific installation guides:
1. Flutter SDK and emulator Installation video for windows - [Windows Installation Video](https://www.youtube.com/watch?v=VFDbZk2xhO4)
2. Flutter SDK and emulator installation video for mac - [Mac Installation Video](https://www.youtube.com/watch?v=QG9bw4rWqrg)

## Step 2: Step up the project and run the prototype locally

1. Clone the repository or unzip the folder.
2. Open the root folder in **Visual Studio Code** like below screenshot
3. Run the following commands:

```bash
flutter pub get
flutter run
```

## List of programming languages, frameworks, or tools

- **Programming Language**: Dart
- **Framework**: Flutter
- **State Management**: GetX
- **Development Tool**: Visual Studio Code or Android studio
- **Target Platform**: Android (Prototype Phase)


## Project Structure

```
lib/
├── main.dart              # Application Entry point
├── core/                  # Utilities (APIConstants, AppColors etc)
├── module/                # Features
│   ├── group/             
│   ├── home/
│   ├── login/
│   └── tasks/
├── service/                
    └── model/             # Data models
```

Each module includes:
- `controller/` – Handles business logics (API calls) and Holds state of the screen (State management).
- `presentation/` – UI components (Screens and Widgets)

## App Consuming APIs

- [Postman collection](https://github.com/Logeshsharma/bus-assignment2-moibleapp-prototype/blob/main/BusAssignment2-MobileAPIs.postman_collection.json)

- **Login API**:

```curl --location 'https://bus-test-f592.onrender.com/login_mobile' 
--header 'Content-Type: application/json' 
--data '{
    "username" : "admin",
    "password" : "admin.pw"
}'
```

- **Get Group Member API**:

```
curl --location 'https://bus-test-f592.onrender.com/get_group_mobile/1'
```

- **Get Task API**

```
curl --location 'https://bus-test-f592.onrender.com/get_tasks_mobile/1'
```

- **Update Task Statu API**

```
curl --location 'https://bus-test-f592.onrender.com/update_task_status' 
--header 'Content-Type: application/json' 
--data '{
    "group_id": 1,
    "task_id": 2,
    "status" : "Completed"
}'
```

- **Get Group Message API**
```
curl --location 'https://bus-test-f592.onrender.com/get_group_messages/1/10'
```


## Key Features - A summary of implemented functionalities

- **User Authentication**: Login using university credentials.
- **Group**: List of students and mentor.
- **Task - Student**: Complete tasks, and receive rewards (Just a status for Prototype Phase).
- **Task - Mentor**: Validate tasks, and approve rewards (Just a status for Prototype Phase).
- **Home**: Hold Task and group features.

## The Webapp Admin page

- *Admin*: [Admin panel (Prototype)](https://bus-test-f592.onrender.com/)


## Team Members

### Mobile app contribution 

- Logesh Sharma Kalimuthan (2845496) 

### Web app contribution (Admin panel)

- Arseniy Vasilko (2072309)
- Charlotte Ashmore (2897025)
- Gurjeevan Pannu (2897368)
- Logesh Sharma Kalimuthan (2845496) 
- Mashrur Hossain Chowdhury Ritom (2867717)

Each team member contributed equally (20%).

### [Git Log](https://github.com/Logeshsharma/bus-assignment2-moibleapp-prototype/blob/main/git-log.txt)




