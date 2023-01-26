import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:chatgptai/src/controllers/HomeController.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static final formKey = GlobalKey<FormState>();
  static final questionTextEditingController = TextEditingController();

  var logger = Logger();
  static HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFD3D3D3 ),
        appBar: myAppBar(context),
        body: myChatBody(context),
      )
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Chat GPT'),
    );
  }

  Widget myChatBody(BuildContext context) {
    return RxBuilder(builder: (BuildContext context) {
      return Column(
        children: [
          Flexible(
            flex: 1,
            child: ListView.builder(
              itemCount: homeController.conversation.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Card(
                        elevation: 100,
                        color: const Color(0xFFFFFFFF),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                          child: Text(
                            'Pergunta: ${homeController.conversation[index]['question']}',
                            style: TextStyle(
                              fontFamily: 'GPT',
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFF000000),
                              fontSize: MediaQuery.of(context).size.height * 1.8 / 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Card(
                        elevation: 100,
                        color: const Color(0xFFFFFFFF),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                          child: Text(
                            'Resposta: ${homeController.conversation[index]['answer']}',
                            style: TextStyle(
                              fontFamily: 'GPT',
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF000000),
                              fontSize: MediaQuery.of(context).size.height * 2 / 100,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Flexible(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(left: 5),
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'GPT',
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF0A0807),
                            fontSize: MediaQuery.of(context).size.height * 2 / 100,
                          ),
                          cursorColor: const Color(0xFF0A0807),
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            hintText: 'Faça uma pergunta...',
                            hintStyle: TextStyle(
                              fontFamily: 'GPT',
                              color: const Color(0xFF0A0807),
                              fontSize: MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            fillColor: const Color(0xFFFFFFFF),
                            labelStyle: TextStyle(
                              fontFamily: 'GPT',
                              color: const Color(0xFF0A0807),
                              fontSize: MediaQuery.of(context).size.height * 2 / 100,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF0A0807),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF0A0807),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            errorStyle: TextStyle(
                              fontFamily: 'GPT',
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFFC4302B),
                              fontSize: MediaQuery.of(context).size.height * 1.5 / 100,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFFC4302B),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return '* Campo obrigatório';
                            } else {
                              return null;
                            }
                          },
                          minLines: 1,
                          maxLines: 5,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          controller: questionTextEditingController,
                        ),
                      )
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.indigo,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          hoverColor: Colors.green,
                          icon: const Icon(Icons.send_outlined),
                          onPressed: () {
                            if (formKey.currentState.validate() == true) {
                              homeController.sendQuestion(questionTextEditingController.text);
                              questionTextEditingController.clear();
                            }
                          },
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
