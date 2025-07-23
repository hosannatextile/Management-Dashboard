class TicketsCompleteData {
  int? count;
  List<TicketDetailsWithUser>? ticketDetails;

  TicketsCompleteData({this.count, this.ticketDetails});

  TicketsCompleteData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['ticketDetails'] != null) {
      ticketDetails = <TicketDetailsWithUser>[];
      json['ticketDetails'].forEach((v) {
        ticketDetails!.add(TicketDetailsWithUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (ticketDetails != null) {
      data['ticketDetails'] =
          ticketDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketDetailsWithUser {
  Ticket? ticket;
  Sender? sender;

  TicketDetailsWithUser({this.ticket, this.sender});

  TicketDetailsWithUser.fromJson(Map<String, dynamic> json) {
    ticket =
        json['ticket'] != null ? Ticket.fromJson(json['ticket']) : null;
    sender =
        json['sender'] != null ? Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticket != null) {
      data['ticket'] = ticket!.toJson();
    }
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    return data;
  }
}

class Ticket {
  Media? media;
  String? sId;
  String? userId;
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

  Ticket(
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

  Ticket.fromJson(Map<String, dynamic> json) {
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    sId = json['_id'];
    userId = json['user_id'];
    recipientIds = json['recipient_ids'].cast<String>();
    type = json['type'];
    description = json['description'];
    priority = json['priority'];
    deadline = json['deadline'];
    status = json['status'];
    rights = json['rights'];
    createdAt = json['created_at'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (media != null) {
      data['media'] = media!.toJson();
    }
    data['_id'] = sId;
    data['user_id'] = userId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voice_note_url'] = voiceNoteUrl;
    data['video_url'] = videoUrl;
    data['image_url'] = imageUrl;
    return data;
  }
}

class Sender {
  String? sId;
  String? fullName;
  String? mobileNumber;
  String? cnic;
  String? email;
  String? profilePhoto;
  String? department;
  String? role;
  String? username;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? status;

  Sender(
      {this.sId,
      this.fullName,
      this.mobileNumber,
      this.cnic,
      this.email,
      this.profilePhoto,
      this.department,
      this.role,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.status});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    mobileNumber = json['mobileNumber'];
    cnic = json['cnic'];
    email = json['email'];
    profilePhoto = json['profilePhoto'];
    department = json['department'];
    role = json['role'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['mobileNumber'] = mobileNumber;
    data['cnic'] = cnic;
    data['email'] = email;
    data['profilePhoto'] = profilePhoto;
    data['department'] = department;
    data['role'] = role;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['status'] = status;
    return data;
  }
}
