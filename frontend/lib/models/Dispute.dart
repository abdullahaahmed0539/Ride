class Dispute {
  String id;
  String initiatorId;
  String defenderId;
  String subject;
  String shortDescription;
  String initiatorsClaim;
  late String defendentsClaim;
  late int initiatorsVote;
  late int defendentsVote;
  DateTime publishedOn;
  String status;

  Dispute(
      {required this.id,
      required this.initiatorId,
      required this.defenderId,
      required this.subject,
      required this.shortDescription,
      required this.initiatorsClaim,
      required this.status,
      required this.publishedOn});

  
}
