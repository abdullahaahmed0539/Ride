class Directions {
  String? humanReadableAddress;
  String? locationName;
  String? locationId;
  double? lat;
  double? long;

  Directions(
      { this.humanReadableAddress,
       this.locationId,
       this.locationName,
       this.lat,
       this.long});
}
