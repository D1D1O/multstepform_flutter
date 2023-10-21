import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cadastro UC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int currentStep = 0;
  bool isCompleted = false;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final postcode = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: isCompleted
            ? Container(
          margin: EdgeInsets.only(top: 200),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.cloud,size: 100),
                Text('Enviado com sucesso!!!'),

                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(onPressed: (){
                    setState(() {
                      isCompleted = false;
                      currentStep = 0;
                      firstName.clear();
                      lastName.clear();
                      address.clear();
                      postcode.clear();
                    });
                  },
                  child: Icon(Icons.reset_tv),),
                )
              ],
            ),
          ),
        )
            : Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.red)),
                child: Stepper(
                  type: StepperType.horizontal,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      setState(() {
                        isCompleted = true;
                      });
                      print('Completed');
                    } else {
                      setState(() => currentStep += 1);
                    }
                  },
                  onStepCancel: currentStep == 0
                      ? null
                      : () => setState(() => currentStep -= 1),
                  onStepTapped: (step) => setState(() {
                    currentStep = step;
                  }),
                  controlsBuilder: (context, details) {
                    final isLastStep = currentStep == getSteps().length - 1;

                    return Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                              onPressed: details.onStepContinue,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          if (currentStep != 0)
                            Expanded(
                              child: ElevatedButton(
                                child: Text('BACK'),
                                onPressed: details.onStepCancel,
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ));
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text('Account'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: firstName,
                decoration: InputDecoration(labelText: 'First name'),
              ),
              TextFormField(
                controller: lastName,
                decoration: InputDecoration(labelText: 'Last name'),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('Address'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: address,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: postcode,
                decoration: InputDecoration(labelText: 'Postcod'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Complete'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First Name: ${firstName.text}'),
              Text('Last Name: ${lastName.text}'),
              Text('Address: ${address.text}'),
              Text('Postcode: ${postcode.text}'),

            ],
          )
        ),
      ];
}

class buildCompleted extends StatelessWidget {
  const buildCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.cloud,size: 100),
            Text('Enviado com sucesso!!!')
          ],
        ),
      ),
    );
  }
}
