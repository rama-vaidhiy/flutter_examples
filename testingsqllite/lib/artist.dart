class Artist {
  int ArtistId = 0;
  String Name = '';

  Artist({required this.ArtistId, required this.Name});

  Map<String, dynamic> toMap() {
    return {
      'ArtistId': ArtistId,
      'Name': Name,
    };
  }

  // Implement toString to make it easier to see information about
  // each artist when using the print statement.
  @override
  String toString() {
    return 'artists{ArtistId: $ArtistId, Name: $Name}';
  }
}
