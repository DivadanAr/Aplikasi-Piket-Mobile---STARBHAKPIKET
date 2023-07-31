import 'package:flutter/material.dart';

void main() => runApp(const trial());

class trial extends StatelessWidget {
  const trial({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Steps(),
    );
  }
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step('Kelas Dua Belas (XII)', 'XII RPL 1'),
    Step('Kelas Dua Belas (XI)', 'XI PPLG 2'),
    Step('Kelas Dua Belas (X)', 'X PPLG 3'),
  ];
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(15),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xff7F669D),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child:
                        Image(image: AssetImage('assets/images/document.png')),
                  ),
                  Text(step.title),
                ],
              ),
            );
          },
          body: Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.only(top: 0, left: 30, right: 30),
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.black45, width: 2.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(step.title), Text('30')],
              ),
            ),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
