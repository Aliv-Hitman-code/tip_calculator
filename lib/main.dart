import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TipCalculatorApp());
}
class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tip Calculator",
      debugShowCheckedModeBanner: false,
      home: TipHomePage(),
    );
  }
}
class TipHomePage extends StatefulWidget {
  const TipHomePage({super.key});

  @override
  State<TipHomePage> createState() => _TipHomePageState();
}

class _TipHomePageState extends State<TipHomePage> {
  TextEditingController billController = TextEditingController();
  double tipAmount = 0;
  double totalAmount = 0;
  int selectedTip = 10;
  void calculateTip() {
    double bill = double.tryParse(billController.text) ?? 0;
    if(bill > 0) {
      setState(() {
        tipAmount = (bill*selectedTip)/100;
        totalAmount = bill + tipAmount;
      });
    }
  }

  void resetData() {
    setState(() {
      tipAmount = 0;
      totalAmount = 0;
      billController.clear;
      selectedTip = 10;
    });
  }
  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("T I P  C A L C U L A T O R",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent[100],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: billController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter your amount",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 20,),
            Text("Select Tip Percentage",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Wrap(
              spacing: 10,
              children: [5,10,15,20].map((value) {
                return ChoiceChip(label: Text("$value%"), selected: selectedTip == value,
                  onSelected: (selected) {
                    setState(() {
                      selectedTip = value;
                    });
                  }
                );
              }).toList(),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: calculateTip, child: Text("Amount")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: resetData, child: Text("Reset")),
            SizedBox(height: 15,),
            Card(
              elevation: 4,
              child: Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Tip Amount is ${tipAmount.toStringAsFixed(2)}"),
                      SizedBox(height: 20,),
                      Text("Total Amount is ${totalAmount.toStringAsFixed(2)}")
                    ],
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }


}