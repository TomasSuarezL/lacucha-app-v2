import 'package:flutter/material.dart';

const env = "dev";

const apiBaseUrlDev = "http://192.168.0.242:5000/api"; // CASA
// const apiBaseUrlDev = "http://192.168.200.10:5000/api"; // CASA FLOR
// const apiBaseUrlDev = "http://192.168.0.159:5000/api"; // CASA CAR

const apiBaseUrlProd = "https://lacucha-app-back.herokuapp.com/api";

var apiBaseUrl = env == "dev" ? apiBaseUrlDev : apiBaseUrlProd;

var secondaryColor = Color(0xFF0F4B6C);
var secondaryColorDark = Color(0xFF093348);
var secondaryColorLight = Color(0xFF3281AE);
var secondaryColorLighter = Color(0xFF9EDAFA);
var googleBackgroundColor = Color(0xFF4285F4);
