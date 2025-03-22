import 'package:flutter/material.dart';
enum NotificationFrequency { daily, weekly, monthly, none }
class Task with ChangeNotifier {

  String title;
  String? parentProject;//set
  double percentageWeighting;//validate
  List<String> listOfTags = [];//set
  int priority;
  DateTime startDate = DateTime.now();//set
  DateTime endDate;
  Map<String, String> members = {};//set
  bool notificationPreference = true;//set
  NotificationFrequency notificationFrequency = NotificationFrequency.daily;
  String description;
  String directoryPath;//set
  List<String>? comments;//set

  Task({
    required this.title,
    this.parentProject,
    required this.percentageWeighting,
    required this.listOfTags, 
    required this.priority,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.members,
    required this.notificationPreference ,
    required this.notificationFrequency ,
    required this.directoryPath,
  List<String>? comments,
  })  :  comments = comments ?? [] {
    // Check if endDate is provided and perform validation
    if ( endDate.isBefore(startDate!)) {
      throw ArgumentError("End date must be after start date.");
    }
    if (description.length > 400) {
      throw Exception("Description is too long.");
    }
  }

  
  // Method to assign a member
  void assignMember(String username, String role) {
    members![username] = role;
    notifyListeners();
  }

  // Method to remove a member
  void removeMember(String username) {
    members!.remove(username);
    notifyListeners();
  }

  // Get the list of members
  List<String> getMembers() {
    return members!.keys.toList();
  }

  // Remove a tag from the list
  void removeTag(String tag) {
    listOfTags!.remove(tag);
    notifyListeners();
  }

  // Get the list of tags
  List<String>? getTags() {
    return listOfTags;
    }

  // Method to check if the user can edit the task
  bool canEdit(String username) {
    return members!.containsKey(username);
  }

 
  // Set the notification frequency
  void setNotificationFrequency(NotificationFrequency frequency) {
    notificationFrequency = frequency;
    notifyListeners();
  }

  // Method to add or update a tag
  void addOrUpdateTag(String oldTag, String newTag) {
    if (newTag.isEmpty) {
      print("New tag cannot be empty.");
      return;
    }
    int index = listOfTags!.indexOf(oldTag);
    if (index != -1) {
      listOfTags![index] = newTag;
    } else {
      listOfTags!.add(newTag);
    }
    notifyListeners();
  }

  // Method to update the task's priority
  void updatePriority(int newPriority) {
    priority = newPriority;
    notifyListeners();
  }

  // Method to update the task's percentage weighting
  void updatePercentageWeighting(double newPercentageWeighting) {
    percentageWeighting = newPercentageWeighting;
    notifyListeners();
  }
  
  // Method to update the task's end date
  void updateEndDate(DateTime newEndDate) {
    if (newEndDate.isBefore(startDate)) {
      throw Exception("End date must be after start date");
    }
    endDate = newEndDate;
    notifyListeners();
  }

  // Method to update the task's description
  void updateDescription(String newDescription) {
    if (newDescription.length > 400) {
      throw Exception("Character limit reached!!!");
    }
    description = newDescription;
    notifyListeners();
  }  

  // Method to update notification preferences
  void updateNotificationPreference(bool newPreference) {
    notificationPreference = newPreference;
    notifyListeners();
  }
}
