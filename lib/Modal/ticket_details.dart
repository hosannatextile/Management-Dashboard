class TicketsDetails {
  String? recipientId;
  int? totalTickets;
  List<Tickets>? tickets;
  TypeCounts? typeCounts;

  TicketsDetails(
      {this.recipientId, this.totalTickets, this.tickets, this.typeCounts});

  TicketsDetails.fromJson(Map<String, dynamic> json) {
    recipientId = json['recipient_id'];
    totalTickets = json['total_tickets'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    typeCounts = json['type_counts'] != null
        ? TypeCounts.fromJson(json['type_counts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recipient_id'] = recipientId;
    data['total_tickets'] = totalTickets;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (typeCounts != null) {
      data['type_counts'] = typeCounts!.toJson();
    }
    return data;
  }
}

class Tickets {
  Media? media;
  String? sId;
  UserId? userId;
  List<String>? recipientIds;
  String? type;
  String? description;
  String? priority;
  String? deadline;
  String? status;
  String? rights;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Tickets(
      {this.media,
      this.sId,
      this.userId,
      this.recipientIds,
      this.type,
      this.description,
      this.priority,
      this.deadline,
      this.status,
      this.rights,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Tickets.fromJson(Map<String, dynamic> json) {
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    sId = json['_id'];
    userId =
        json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    recipientIds = json['recipient_ids'].cast<String>();
    type = json['type'];
    description = json['description'];
    priority = json['priority'];
    deadline = json['deadline'];
    status = json['status'];
    rights = json['rights'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['_id'] = sId;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['recipient_ids'] = recipientIds;
    data['type'] = type;
    data['description'] = description;
    data['priority'] = priority;
    data['deadline'] = deadline;
    data['status'] = status;
    data['rights'] = rights;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Media {
  String? voiceNoteUrl;
  String? videoUrl;
  String? imageUrl;

  Media({this.voiceNoteUrl, this.videoUrl, this.imageUrl});

  Media.fromJson(Map<String, dynamic> json) {
    voiceNoteUrl = json['voice_note_url'];
    videoUrl = json['video_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['voice_note_url'] = voiceNoteUrl;
    data['video_url'] = videoUrl;
    data['image_url'] = imageUrl;
    return data;
  }
}

class UserId {
  String? sId;
  String? fullName;

  UserId({this.sId, this.fullName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    return data;
  }
}

class TypeCounts {
  int? permission;
  int? complaint;
  int?problem;
  int? requirement;
  int? training;
  int? reimbursement;
  TypeCounts({this.permission, this.complaint, this.problem, this.requirement, this.training, this.reimbursement});

  TypeCounts.fromJson(Map<String, dynamic> json) {
    permission = json['Permission'];
    complaint = json['Complaint'];
    problem = json['Problem'];
    requirement = json['Requirement'];
    training = json['Training'];
    reimbursement = json['Reimbursement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Permission'] = permission;
    data['Complaint'] = complaint;
    data['Problem'] = problem;
    data['Requirement'] = requirement;
    data['Training'] = training;
    data['Reimbursement'] = reimbursement;
    return data;
  }
}
