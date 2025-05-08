# Mix&Match - Speed Friending App for University Freshers

Mix&Match is a system designed to support freshers and international students in overcoming common social, cultural, and academic challenges when entering university. The creates dynamic peer groups, encourages group-based activities, and connects students with mentors to improve social integration and overall well-being.

This documentation focuses on the mobile component of the Mix&Match system - Mix&Match Android which is primarily used by the Student and Mentor.

### Disclaimer: The Current implementation of the Android APP is synchronised with the Web APP via the Link: https://bus-test-f592.onrender.com if the Web App is run locally on a machine by unzipping the project file and using an IDE like pycharm then the APP will not be synchronised with the locally displayed instances of the Web APP. Additionally, the hosting system resets the database approx every 15 mins, and may take up to a minute to load for the first time due to the nature of the hosting platform.

- ## Project Overview - A brief description of Our current system prototype

This prototype focuses on demonstrating the foundational features of the platform with clean navigation and modular design.
This Prototype for Mix&Match is able to:
1. Allow students to view their respective groups and tasks and mark them as complete.
2. Allows Mentors to view tasks and approve them and view respective group members.


## Features: Core functionalities implemented in this android app
- Task completion/validation:
  - **Students**: Able to view tasks and their statuses from their respective groups and mark their tasks as completed.
  - **Mentors**: Able to view tasks from their respective groups and approve the tasks pending approval

  *Note:* A significant part of this functionality is implemented in the Mix&Match Admin Web App, as all task details are stored in the Admin App's database. For more details about this functionality and implementation please refer to the Mix&Match Admin Web App's documentation or view the source code at: https://github.com/Logeshsharma/bus-assignment2-prototype.git 
  

## Features: Secondary/Supporting functionalities
1. Group Member Viewing
2. Login
3. Logout

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

## APK - Downloadable link

- [APK](https://bham-my.sharepoint.com/personal/lxk496_student_bham_ac_uk/_layouts/15/guestaccess.aspx?share=EXeFBJE7jrJOmbL3hGiAb2cBPfHMTGpDa8g8igaZPoLSpA&e=3hWqnW)
 - If the app is not installing follow this troubleshoot video - [Troubleshoot video](https://www.youtube.com/shorts/kbMM0vMmMPc)


## The Webapp Admin page

- *Admin*: [Admin panel (Prototype)](https://bus-test-f592.onrender.com/)


## Team Members

### Mobile app contribution 

- Logesh Sharma Kalimuthan (2845496) 
- Mashrur Hossain Chowdhury Ritom (2867717)

### Web app contribution (Admin panel)

- Arseniy Vasilko (2072309)
- Charlotte Ashmore (2897025)
- Gurjeevan Pannu (2897368)
- Logesh Sharma Kalimuthan (2845496) 
- Mashrur Hossain Chowdhury Ritom (2867717)

Each team member contributed equally (20%).

### [Git Log](https://github.com/Logeshsharma/bus-assignment2-moibleapp-prototype/blob/main/git-log.txt)




