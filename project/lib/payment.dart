//aya
import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;

import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';

class Payment {
  static Map<String, dynamic>? paymentIntent;
  static bool isPay = false;
  static List<int> selectedListToPay = [];
  static List<Map<String, dynamic>> productCart = [];
  //
  static Function()? onPaymentSuccess;

  static void makePayment(BuildContext context, double amount) async {
    print(' in makePayment ');
    print(amount);
    String merchantCountryCode = "IL";
    String currencyCode = "ILS";

    print(merchantCountryCode);
    print(currencyCode);
    try {
      paymentIntent = await createPaymentIntent(amount, context, currencyCode);
      var gPay = PaymentSheetGooglePay(
          merchantCountryCode: merchantCountryCode,
          currencyCode: currencyCode,
          testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Sabir",
        googlePay: gPay,
      ));
      displayPaymentIntent(context, amount);
    } catch (e) {}
  }

  static void displayPaymentIntent(BuildContext context, double amount) async {
    try {
      print('***********before');
      await Stripe.instance.presentPaymentSheet();
      print('***********after');

      isPay = true;
      print('Done');

      Flushbar(
        message: "Payment Done",
        duration: Duration(seconds: 3),
        // backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
      if (onPaymentSuccess != null) {
        onPaymentSuccess!();
      }
    } catch (e) {
      Flushbar(
        message: "Payment Failed",
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
      print('Failed Pay');
    }
  }

  static createPaymentIntent(
      double amount, BuildContext context, String currencyCode) async {
    try {
      print(amount);
      print(currencyCode);
      final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
      int amountInCents = (amount * 100).toInt();
      Map<String, dynamic> body = {
        "amount": amountInCents.toString(),
        "currency": currencyCode,
      };
      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        print(json);
        return json;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "CHECKOUT Failed\nSelect Item to CHECKOUT",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ));
        print('error in calling payment intent');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
