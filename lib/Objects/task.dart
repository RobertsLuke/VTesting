enum NotificationFrequency { daily, weekly, monthly, none }

class Task {
  String title;
  String? parentTask;
  double percentageWeighting;
  List<String> listOfTags;
  int priority;
  DateTime startDate;
  DateTime endDate;
  Map<String, String> members;
  bool notificationPreference;
  NotificationFrequency notificationFrequency;
  String description;
  String directoryPath;
  List<String> comments;

  Task({
    required this.title,
    this.parentTask,
    required this.percentageWeighting,
    required this.listOfTags, // Could be empty??
    required this.priority,
    DateTime? startDate,
    required this.endDate,
    required this.description,
    required this.members,
    this.notificationPreference = true,
    this.notificationFrequency = NotificationFrequency.daily,
    required this.directoryPath,
    List<String>? comments,
  })  : startDate = startDate ?? DateTime.now(),
        comments = comments ?? [] {
    if (description.length > 400) {
      throw Exception("Character limit reached!!!");
    }
  }

  void assignMember(String username, String role) {
    members[username] = role;
  }

  void removeMember(String username) {
    members.remove(username);
  }

  List<String> getMembers() {
    return members.keys.toList();
  }

  void addTag(String tag) {
    if (!listOfTags.contains(tag)) {
      listOfTags.add(tag);
    }
  }

  void removeTag(String tag) {
    listOfTags.remove(tag);
  }

  bool canEdit(String username) {
    return members.containsKey(username);
  }

  bool validDeadLine() {
    return endDate.isAfter(startDate);
  }

  void setNotificationFrequency(NotificationFrequency frequency) {
    notificationFrequency = frequency;
  }

  void addOrUpdateTag(String oldTag, String newTag) {
    if (newTag.isEmpty) {
      print("New tag cannot be empty.");
      return;
    }
    int index = listOfTags.indexOf(oldTag);
    if (index != -1) {
      listOfTags[index] = newTag;
    } else {
      listOfTags.add(newTag);
    }
  }
}