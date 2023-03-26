import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
              suffixIcon:const Icon(Icons.send),
              suffixIconColor:mainColor,
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 123, 230, 219)),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: mainColor),borderRadius:BorderRadius.circular(20), ),
              hintText: "type message here",
              fillColor: Colors.white70),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 223, 206, 158),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/works/profile pic.jpg'),
              radius: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'James Miller',
              style: mediumText,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Text(
            'today',
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      MessagingContainer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      ReplyContainer(),
                    ],
                  ),
                ],
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class MessagingContainer extends StatelessWidget {
  const MessagingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 310,
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Hello , Iam cristinal,I need Your service',
                    style: normalText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('10:40')],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReplyContainer extends StatelessWidget {
  const ReplyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 240,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ok , we are ready to do for you',
                    style: normalText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('10:50')],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class ChatContainer extends StatelessWidget {
//    ChatContainer({
//     super.key,required this.chat,required this.color
//   });
// String chat;
// Color color;
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }