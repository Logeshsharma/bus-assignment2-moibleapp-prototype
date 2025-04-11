import 'dart:convert';

GroupTask groupTaskFromJson(String str) => GroupTask.fromJson(json.decode(str));

String groupTaskToJson(GroupTask data) => json.encode(data.toJson());

class GroupTask {
    final int? groupId;
    final List<Task>? tasks;

    GroupTask({
        this.groupId,
        this.tasks,
    });

    GroupTask copyWith({
        int? groupId,
        List<Task>? tasks,
    }) => 
        GroupTask(
            groupId: groupId ?? this.groupId,
            tasks: tasks ?? this.tasks,
        );

    factory GroupTask.fromJson(Map<String, dynamic> json) => GroupTask(
        groupId: json["group_id"],
        tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "group_id": groupId,
        "tasks": tasks == null ? [] : List<dynamic>.from(tasks!.map((x) => x.toJson())),
    };
}

class Task {
    final String? desc;
    final String? endDatetime;
    final int? id;
    final bool? isUpload;
    final String? location;
    final String? startDatetime;
    final String? status;
    final String? title;

    Task({
        this.desc,
        this.endDatetime,
        this.id,
        this.isUpload,
        this.location,
        this.startDatetime,
        this.status,
        this.title,
    });

    Task copyWith({
        String? desc,
        String? endDatetime,
        int? id,
        bool? isUpload,
        String? location,
        String? startDatetime,
        String? status,
        String? title,
    }) => 
        Task(
            desc: desc ?? this.desc,
            endDatetime: endDatetime ?? this.endDatetime,
            id: id ?? this.id,
            isUpload: isUpload ?? this.isUpload,
            location: location ?? this.location,
            startDatetime: startDatetime ?? this.startDatetime,
            status: status ?? this.status,
            title: title ?? this.title,
        );

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        desc: json["desc"],
        endDatetime: json["end_datetime"],
        id: json["id"],
        isUpload: json["isUpload"],
        location: json["location"],
        startDatetime: json["start_datetime"],
        status: json["status"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "desc": desc,
        "end_datetime": endDatetime,
        "id": id,
        "isUpload": isUpload,
        "location": location,
        "start_datetime": startDatetime,
        "status": status,
        "title": title,
    };
}

