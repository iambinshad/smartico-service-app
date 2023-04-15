class ChatRoomModel{
  String? chatRoomId ;
  List<String>? participants;

  ChatRoomModel({this.chatRoomId,this.participants});

  ChatRoomModel.fromMap(Map<String,dynamic>map){
    chatRoomId = map["chatroomid"];
    participants = map["participants"];
  }

  Map<String,dynamic>toMap(){
    return{
      "chatroomid":chatRoomId,
      "participants":participants,
    };
  }
} 