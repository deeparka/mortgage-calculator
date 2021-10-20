import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:math';

class mortgage extends StatefulWidget {
  const mortgage({Key? key}) : super(key: key);

  @override
  _mortgageState createState() => _mortgageState();
}

class _mortgageState extends State<mortgage> {
  int _loanYearCount = 1;
  double _homePrice = 0.0;
  int _interestRate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mortgage Payments"),
      ),
      body: Container(
        //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.yellowAccent.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Monthly Payment",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "\$${calculateMonthlyPayment(_loanYearCount, _homePrice, _interestRate)}",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 22.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.yellow.shade400,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.2),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixText: "Home Price: ",
                      prefixIcon: Icon(Icons.home),
                    ),
                    onChanged: (String price) {
                      try {
                        _homePrice = double.parse(price);
                      } catch (exception) {
                        _homePrice = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Length of Loan(years)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_loanYearCount > 1) {
                                  _loanYearCount--;
                                }
                              });
                            },
                            child: Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_loanYearCount",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _loanYearCount++;
                              });
                            },
                            child: Container(
                              height: 50.0,
                              width: 50.0,
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Interest",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text(
                          "$_interestRate%",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Slider(
                          min: 0,
                          max: 50,
                          inactiveColor: Colors.black,
                          activeColor: Colors.orange.shade800,
                          value: _interestRate.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _interestRate = newValue.round();
                            });
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateMonthlyPayment(
      int loanYearCount, double homePrice, int interestRate) {
    double monthlyPayment = 0.0;
    // ignore: unnecessary_null_comparison
    if (homePrice < 0 || homePrice.toString().isEmpty || homePrice == null) {
    } else {
      monthlyPayment =
          homePrice * pow((1 + (interestRate / 100.0)), loanYearCount);
    }
    return monthlyPayment;
  }
}
