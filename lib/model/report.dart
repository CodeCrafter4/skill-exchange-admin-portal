
class reports {
  String? contractID;
  String? contractStatus;
  String? unit;
  String? contractDate;
  String? contractBy;
  String? employerId;
  String? complainID;
  String? userID;
  DateTime? complainDate;
  String? complain;
  String? userName;

  reports({
    this.contractID,
    this.contractStatus,
    this.unit,
    this.contractDate,
    this.contractBy,
    this.employerId,
    this.complainID,
    this.complainDate,
    this.complain,
    this.userName,
  });
  reports.fromJson(Map<String, dynamic> json)
  {
    contractID = json["contractID"];
    contractStatus = json["contractStatus"];
    unit = json["unit"];
    contractDate = json["contractDate"];
    contractBy = json["contractBy"];
    employerId = json["employerId"];
    unit = json["unit"];
    complainDate = json["complainDate"].toDate();
    complain = json["complain"];
    userName = json["longDescription"];
  }

}