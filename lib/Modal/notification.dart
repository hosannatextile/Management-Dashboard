class NotificationModel {
  String? sId;
  String? receiverId;
  String? senderId;
  String? type;
  String? status;
  String? description;
  String? datetime;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? senderName;

  NotificationModel(
      {this.sId,
      this.receiverId,
      this.senderId,
      this.type,
      this.status,
      this.description,
      this.datetime,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.senderName});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiverId = json['receiver_id'];
    senderId = json['sender_id'];
    type = json['type'];
    status = json['status'];
    description = json['description'];
    datetime = json['datetime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    senderName = json['sender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['receiver_id'] = this.receiverId;
    data['sender_id'] = this.senderId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['sender_name'] = this.senderName;
    return data;
  }
}
