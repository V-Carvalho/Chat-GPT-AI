import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: myAppBar(context),
      body: myChatBody(context),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: const Color(0xFF202123),
      title: const Text('Chat GPT'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.share,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Share.share(
              'https://play.google.com/store/apps/details?id=vcode.chatgptai',
              subject: 'Baixe já o Chat GPT a inteligência artifical que revolucionou o mundo!',
            );
          },
        ),
      ],
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
                      margin: index % 2 == 0 ?
                      const EdgeInsets.only(right: 40)
                        :
                      const EdgeInsets.only(left: 40),
                      child: Card(
                        elevation: 20,
                        color: index % 2 == 0 ?
                        const Color(0xFFF5F5F5)
                          :
                        const Color(0xFF202123),
                        shape: RoundedRectangleBorder(
                          borderRadius: index % 2 == 0 ?
                          const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )
                            :
                          const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                          child: Text(
                            index % 2 == 0 ?
                            '${homeController.conversation[index]['message']}'
                              :
                            'ChatGPT: ${homeController.conversation[index]['message']}',
                            style: TextStyle(
                              fontFamily: 'GPT',
                              fontWeight: index % 2 == 0 ?
                              FontWeight.normal
                                :
                              FontWeight.bold,
                              color: index % 2 == 0 ?
                              const Color(0xFF202123)
                                :
                              const Color(0xFFFFFFFF),
                              fontSize: index % 2 == 0 ?
                              MediaQuery.of(context).size.height * 1.8 / 100
                                :
                              MediaQuery.of(context).size.height * 2 / 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Flexible(
            flex: homeController.isResearching.value == true ? 1 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homeController.isResearching.value == true ?
                Container(
                  child: myCircularProgressIndicator(context, const Color(0xFF202123)),
                )
                  :
                Container(),
                Container(
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
                                color: const Color(0xFF202123),
                                fontSize: MediaQuery.of(context).size.height * 2 / 100,
                              ),
                              cursorColor: const Color(0xFF202123),
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                hintText: 'Faça uma pergunta...',
                                hintStyle: TextStyle(
                                  fontFamily: 'GPT',
                                  color: const Color(0xFF202123),
                                  fontSize: MediaQuery.of(context).size.height * 2 / 100,
                                ),
                                fillColor: const Color(0xFFFFFFFF),
                                labelStyle: TextStyle(
                                  fontFamily: 'GPT',
                                  color: const Color(0xFF202123),
                                  fontSize: MediaQuery.of(context).size.height * 2 / 100,
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF202123),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFF202123),
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
                              color: Color(0xFF202123),
                              shape: CircleBorder(),
                            ),
                            child: IconButton( //
                              color: const Color(0xFFFFFFFF),
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
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget myCircularProgressIndicator(BuildContext context, Color color) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

}
