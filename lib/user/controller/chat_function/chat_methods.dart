class ChatMethods {
  String checkingId({required String vendorId, required String currentUser}) {
    if (vendorId[0].toLowerCase().codeUnits[0] >
        currentUser.toLowerCase().codeUnits[0]) {
      return "$vendorId$currentUser";
    } else {
      return "$currentUser$vendorId";
    }
  }
}