import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'chat_message.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<AnimatedListState> _animaListKey = GlobalKey<AnimatedListState>();

  TextEditingController _textEditingController = TextEditingController();
  List<String> _chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(itemBuilder: _buildItem, reverse: true,key: _animaListKey),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Send a Message",),
                    controller: _textEditingController,
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                TextButton(
                    onPressed: (){
                      _handleSubmitted(_textEditingController.text);
                    },
                    child: Text("send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text){
    Logger().d(text);
    _textEditingController.clear();
    _chats.insert(0,text);
    _animaListKey.currentState.insertItem(0);
  }
  
  Widget _buildItem(context, index, animation) {
    return ChatMessage(_chats[index],animation);
  }
}
