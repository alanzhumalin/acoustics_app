import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetail extends ConsumerStatefulWidget {
  const ChatDetail({super.key, required this.name});
  final String name;

  @override
  ConsumerState<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends ConsumerState<ChatDetail> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {"text": "Привет!", "isMe": false},
    {"text": "Как дела?", "isMe": false},
    {"text": "Все отлично, спасибо!", "isMe": true},
    {"text": "Отлично, рад слышать!", "isMe": false},
  ];

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({"text": _messageController.text, "isMe": true});
      });
      _messageController.clear();
    }
  }

  bool isClosed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.surfaceContainer;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.amber,
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          forceMaterialTransparency: true,
        ),
        body: Column(
          children: [
            if (!isClosed)
              Opacity(
                opacity: 0.8,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      color: theme,
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/speakers/k1.jpeg')),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alex Sanches',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Продам L acoustics k1',
                                  style: TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '???',
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Text(
                            DateTime.now().year.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        right: -5,
                        top: -5,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                isClosed = true;
                              });
                            },
                            icon: Icon(CupertinoIcons.clear_fill)))
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isMe = message["isMe"] as bool;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                      decoration: BoxDecoration(
                        color: isMe
                            ? const Color.fromARGB(255, 12, 73, 122)
                            : const Color.fromARGB(255, 89, 89, 89),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft: isMe
                              ? const Radius.circular(15)
                              : const Radius.circular(0),
                          bottomRight: isMe
                              ? const Radius.circular(0)
                              : const Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message["text"] as String,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '15:12',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 20, bottom: 30, top: 10),
              color: const Color.fromARGB(255, 45, 45, 45),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blue,
                      controller: _messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        hintText: "Введите сообщение",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 74, 68, 61)),
                      child: Center(
                        child: Icon(Icons.send_rounded, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
