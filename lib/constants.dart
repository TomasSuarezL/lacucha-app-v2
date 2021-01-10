import 'package:flutter/material.dart';

const env = "dev";

// const apiBaseUrlDev = "http://192.168.0.41:5000/api"; // CASA
// const apiBaseUrlDev = "http://192.168.200.10:5000/api"; // CASA FLOR
const apiBaseUrlDev = "http://192.168.1.34:5000/api"; // CASA CAR

const apiBaseUrlProd = "ToDo";

var apiBaseUrl = env == "dev" ? apiBaseUrlDev : apiBaseUrlProd;

var secondaryColor = Color(0xFF0F4B6C);
var secondaryColorDark = Color(0xFF093348);
var secondaryColorLight = Color(0xFF3281AE);
