

class AdminActivity {
  String? sId;
  String? fullName;
  String? email;
  String? role;
  List<Assignments>? assignments;

  AdminActivity(
      {this.sId, this.fullName, this.email, this.role, this.assignments});

  AdminActivity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(new Assignments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['role'] = this.role;
    if (this.assignments != null) {
      data['assignments'] = this.assignments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignments {
  String? sId;
  dynamic ticketId;
  UserId? userId;
  // List<AssignTo>? assignTo;
  String? details;
  MediaType? mediaType;
  String? priority;
  String? targetgetDate;
  String? createdAt;
  int? iV;
  String? status;

  Assignments(
      {this.sId,
      this.ticketId,
      this.userId,
      // this.assignTo,
      this.details,
      this.mediaType,
      this.priority,
      this.targetgetDate,
      this.createdAt,
      this.iV,
      this.status});

  Assignments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticket_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    if (json['assign_to'] != null) {
      // assignTo = <AssignTo>[];
      // json['assign_to'].forEach((v) {
      //   assignTo!.add(new AssignTo.fromJson(v));
      // });
    }
    details = json['Details'];
    mediaType = json['media_type'] != null
        ? new MediaType.fromJson(json['media_type'])
        : null;
    priority = json['priority'];
    targetgetDate = json['targetget_date'];
    createdAt = json['created_at'];
    iV = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ticket_id'] = this.ticketId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    // if (this.assignTo != null) {
    //   data['assign_to'] = this.assignTo!.map((v) => v).toList();
    // }
    data['Details'] = this.details;
    if (this.mediaType != null) {
      data['media_type'] = this.mediaType!.toJson();
    }
    data['priority'] = this.priority;
    data['targetget_date'] = this.targetgetDate;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['status'] = this.status;
    return data;
  }
}

class UserId {
  String? sId;
  String? fullName;
  String? email;

  UserId({this.sId, this.fullName, this.email});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}

class MediaType {
  String? voiceNoteUrl;

  MediaType({this.voiceNoteUrl});

  MediaType.fromJson(Map<String, dynamic> json) {
    voiceNoteUrl = json['voice_note_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voice_note_url'] = this.voiceNoteUrl;
    return data;
  }
}
