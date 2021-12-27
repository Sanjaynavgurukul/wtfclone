class GymSlotModel {
  bool status;
  String message;
  List<SlotData> data;

  GymSlotModel({this.status, this.message, this.data});

  GymSlotModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<SlotData>();
      json['data'].forEach((v) {
        data.add(new SlotData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class SlotData {
  String uid;
  String gymId;
  String trainerId;
  String startTime;
  String endTime;
  String slot;
  String dateAdded;
  String lastUpdated;
  String status;
  String addonId;
  String date;

  SlotData(
      {this.uid,
      this.gymId,
      this.trainerId,
      this.startTime,
      this.endTime,
      this.slot,
      this.dateAdded,
      this.lastUpdated,
      this.status,
      this.addonId,
      this.date});

  SlotData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    gymId = json['gym_id'];
    trainerId = json['trainer_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    slot = json['slot'];
    dateAdded = json['date_added'];
    lastUpdated = json['last_updated'];
    status = json['status'];
    addonId = json['addon_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['gym_id'] = this.gymId;
    data['trainer_id'] = this.trainerId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['slot'] = this.slot;
    data['date_added'] = this.dateAdded;
    data['last_updated'] = this.lastUpdated;
    data['status'] = this.status;
    data['addon_id'] = this.addonId;
    data['date'] = this.date;
    return data;
  }
}
