import '/screens/final_screen.dart';
import '/widgets/doors/unlocked_door.dart';
import 'package:flutter/material.dart';

class UnlockedDoorScreen extends StatefulWidget {
  const UnlockedDoorScreen({Key? key}) : super(key: key);

  @override
  _UnlockedDoorScreenState createState() => _UnlockedDoorScreenState();
}

class _UnlockedDoorScreenState extends State<UnlockedDoorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The door is opened!"),
        centerTitle: true,
      ),
      body: SafeArea(
        //a stack widget shows the first child in children as the bottom layer and adds layers on top of it
        child: Stack(
          children: [
            const Center(child: UnlockedDoor()),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Lock the door"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      String? player = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return const PlayerNameInput();
                          });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FinalScreen(
                            player: player ?? '',
                          ),
                        ),
                      );
                    },
                    child: const Text("Step through the door"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerNameInput extends StatefulWidget {
  const PlayerNameInput({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayerNameInput> createState() => _PlayerNameInputState();
}

class _PlayerNameInputState extends State<PlayerNameInput> {
  TextEditingController controller = TextEditingController();

  String status = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text("The Narrator want to know your name",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.words,
                    cursorColor: Colors.black,
                    cursorHeight: 20,
                    controller: controller,
                  ),
                  if (status.isNotEmpty)
                    Text(status,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Navigator.of(context).pop(controller.text);
                  } else {
                    if (mounted) {
                      setState(() {
                        status =
                            "Please Input Your Name. Click Proceed when done";
                      });
                    }
                  }
                },
                child: const Text(
                  "Proceed",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
