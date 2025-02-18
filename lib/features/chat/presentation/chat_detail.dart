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
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
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
    scrollDown();
  }

  bool isClosed = false;

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 1),
        curve: Curves.linear,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(Duration(milliseconds: 300), () => scrollDown());
      }
    });
    Future.delayed(Duration(milliseconds: 1), () => scrollDown());
  }

  void showDialogMessage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 17, 17, 17),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.report_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Заблокировать',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.flag_circle,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Пожаловаться',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 30,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Переместить в Корзину',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Закрыть',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.surfaceContainer;
    final themeContainer = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                InkWell(onTap: showDialogMessage, child: Icon(Icons.more_horiz))
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
                  controller: scrollController,
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message["isMe"] as bool;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 9),
                        decoration: BoxDecoration(
                          color: isMe
                              ? themeContainer.surfaceContainerHigh
                              : themeContainer.surfaceContainerLow,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 10, bottom: 30, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
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
                    IconButton(
                      onPressed: sendMessage,
                      icon: Icon(Icons.arrow_upward, color: Colors.blue),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
