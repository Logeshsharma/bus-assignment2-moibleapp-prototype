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
    final int? id;
    final bool? isUpload;
    final String? status;
    final String? title;

    Task({
        this.desc,
        this.id,
        this.isUpload,
        this.status,
        this.title,
    });

    Task copyWith({
        String? desc,
        int? id,
        bool? isUpload,
        String? status,
        String? title,
    }) => 
        Task(
            desc: desc ?? this.desc,
            id: id ?? this.id,
            isUpload: isUpload ?? this.isUpload,
            status: status ?? this.status,
            title: title ?? this.title,
        );

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        desc: json["desc"],
        id: json["id"],
        isUpload: json["isUpload"],
        status: json["status"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "isUpload": isUpload,
        "status": status,
        "title": title,
    };
}
