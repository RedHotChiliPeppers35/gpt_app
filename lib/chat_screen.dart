import 'package:flutter/material.dart';
import 'package:flutter_application_2/gpt.dart';

class ChatScreen
    extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState
    extends State<ChatScreen> {
  final OpenAIGPTService gptService = OpenAIGPTService('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', "https://api.openai.com/v1/chat/completions");
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  Future _handleSubmitted(String text) async {
    _textController.clear();

    setState(() {
      _messages.add('You: $text');
    });

    try {
      String response = await gptService.generateResponse(text);
      setState(() {
        _messages.add('ChatGPT: $response');
      });
    } catch (e) {
      setState(() {
        _messages.add('Error: Failed to get ChatGPT response: $e');
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          "Header",
          style: TextStyle(color: Colors.green.shade900),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          _buildTextComposer(),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }
}
