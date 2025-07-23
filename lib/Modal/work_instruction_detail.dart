class WorkInstructionDetail {
  String? userId;
  int? count;
  List<Instructions>? instructions;

  WorkInstructionDetail({this.userId, this.count, this.instructions});

  WorkInstructionDetail.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    count = json['count'];
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(Instructions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['count'] = count;
    if (instructions != null) {
      data['instructions'] = instructions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instructions {
  ProofMedia? proofMedia;
  String? sId;
  String? userId;
  List<RecipientIds>? recipientIds;
  String? type;
  String? remarks;
  String? savedTime;
  String? reviewTime;
  String? orderType;
  List<String>? mediaSelect;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Instructions(
      {this.proofMedia,
      this.sId,
      this.userId,
      this.recipientIds,
      this.type,
      this.remarks,
      this.savedTime,
      this.reviewTime,
      this.orderType,
      this.mediaSelect,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Instructions.fromJson(Map<String, dynamic> json) {
    proofMedia = json['proof_media'] != null
        ? ProofMedia.fromJson(json['proof_media'])
        : null;
    sId = json['_id'];
    userId = json['user_id'];
    if (json['recipient_ids'] != null) {
      recipientIds = <RecipientIds>[];
      json['recipient_ids'].forEach((v) {
        recipientIds!.add(RecipientIds.fromJson(v));
      });
    }
    type = json['type'];
    remarks = json['remarks'];
    savedTime = json['saved_time'];
    reviewTime = json['review_time'];
    orderType = json['order_type'];
    mediaSelect = json['media_select'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (proofMedia != null) {
      data['proof_media'] = proofMedia!.toJson();
    }
    data['_id'] = sId;
    data['user_id'] = userId;
    if (recipientIds != null) {
      data['recipient_ids'] =
          recipientIds!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['remarks'] = remarks;
    data['saved_time'] = savedTime;
    data['review_time'] = reviewTime;
    data['order_type'] = orderType;
    data['media_select'] = mediaSelect;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ProofMedia {
  String? audioUrl;
  String? videoUrl;
  String? imageUrl;

  ProofMedia({this.audioUrl, this.videoUrl, this.imageUrl});

  ProofMedia.fromJson(Map<String, dynamic> json) {
    audioUrl = json['audio_url'];
    videoUrl = json['video_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['audio_url'] = audioUrl;
    data['video_url'] = videoUrl;
    data['image_url'] = imageUrl;
    return data;
  }
}

class RecipientIds {
  String? sId;

  RecipientIds({this.sId});

  RecipientIds.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    return data;
  }
}
