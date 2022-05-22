import 'package:flutter/material.dart';
class StepperEx extends StatefulWidget {
  const StepperEx({Key? key}) : super(key: key);

  @override
  State<StepperEx> createState() => _StepperExState();
}

class _StepperExState extends State<StepperEx> {
  int _index = 0;
  bool _complete = false;
  StepperType _type = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper Example'),
        centerTitle: true,
      ),
      body: _complete?
       Container(
        child: Center(
          child: Text(
            'Success!',
            style: TextStyle(
                fontSize: 50,
                color: Colors.pink.shade500
            ),
          ),
        ),
      )
          :Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.red.shade600)
        ),
        child: Stepper(
          currentStep: _index,
          type: _type,
          onStepCancel: () {
            if(_index > 0) {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            final isLastStep = _index == createSteps().length - 1;
            if (isLastStep) {
              print('Completed all steps');
              setState(() {
                _complete = true;
              });
            } else {
              setState(() {
                _index += 1;
              });
            }
          },

          onStepTapped: (int index) {
            setState(() {
              _index = index;
            });
          }
          ,
          steps: createSteps(),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container(
              margin: EdgeInsets.only(top: 40),
              child:Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: _index < createSteps().length -1 ? Text('NEXT') : Text('Finish'),

                    ),
                  ),
                  SizedBox(width: 20,),
                  if(_index != 0)
                    Expanded(
                      child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: Text('BACK'),
                          style: ElevatedButton.styleFrom(primary: Colors.grey.shade400)
                      ),
                    ),
                ],
              ),
            );
          },


        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _type == StepperType.vertical ? _type = StepperType.horizontal :_type = StepperType.vertical ;
          });
        },
        child: Text('Switch'),
      ),
    );
  }

  List<Step> createSteps() => [
    Step(
        isActive: _index >= 0,
        title: Text('Account'),
        subtitle: Text('Enter you Email and Password'),
        state: _index > 0 ? StepState.complete : StepState.indexed,
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        )
    ),
    Step(
        title: Text('Phone'),
        subtitle: Text('Enter your phone number'),
        isActive: _index >= 1,
        state: _index > 0 ? StepState.complete : StepState.indexed,
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone'),
            ),
          ],
        )
    ),
    Step(
        title: Text('Address'),
        subtitle: Text('Enter your address'),
        isActive: _index >= 2,
        state: _index > 0 ? StepState.complete : StepState.indexed,
        content: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Postcode'),
            ),
          ],
        )
    ),
  ];
}
