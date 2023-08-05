import 'package:flutter/material.dart';



Widget blankBox() {
  return const SizedBox(
    height: 0,
    width: 0,
  );
}

extension SizeExtention on num {
  SizedBox height() {
    return SizedBox(
      height: this.toDouble(),
    );
  }

  SizedBox width() {
    return SizedBox(
      width: this.toDouble(),
    );
  }
}

var screensJsonData={
  "screens": [
    {
      "screen_name": "name",
      "heading": "A few personal details please 🙂",
      "question": "My name is",
      "hint_text": "Enter your Name",
      "fields": [
        "textfield"
      ],
      "options": null,
      "ans": null
    },
    {
      "screen_name": "gender",
      "heading": "A few personal details please 🙂",
      "question": "I am a",
      "fields": [
        "radio"
      ],
      "options": [
        {
          "text": "Male",
          "value": "male"
        },
        {
          "text": "Female",
          "value": "female"
        }
      ],
      "ans": null
    },
    {
      "screen_name": "dob",
      "heading": "A few personal details please 🙂",
      "question": "born on",
      "hint_text": "Select date of birth",
      "fields": [
        "datefield"
      ],
      "ans": null
    },
    {
      "screen_name": "profession",
      "heading": "Something about how you keep busy. 💻",
      "question": "I am",
      "fields": [
        "radio"
      ],
      "hint_text": "Select Options",
      "options": [
        {
          "key": "frontend",
          "text": "a frontend developer",
          "value": "a frontend developer"
        },
        {
          "key": "backend",
          "text": "a backend developer",
          "value": "a backend developer"
        },
        {
          "key": "designing",
          "text": "a UI/UX designer",
          "value": "a UI/UX designer"
        }
      ],
      "ans": null,
      "child_screen": {
        "frontend": [
          {
            "screen_name": "technology",
            "heading": "Something about how you keep busy. 💻",
            "question": "and I develop",
            "fields": [
              "radio"
            ],
            "options": [
              {
                "text": "Web Application",
                "value": "web application"
              },
              {
                "text": "Mobile Application",
                "value": "mobile Application"
              }
            ],
            "ans": null
          }
        ],
        "backend": [
          {
            "screen_name": "technology",
            "heading": "Something about how you keep busy. 💻",
            "question": "and I have knowledge of",
            "hint_text": "Enter technology name",
            "fields": [
              "textfield"
            ],
            "options": null,
            "ans": null
          }
        ],
        "designing": [
          {
            "screen_name": "technology",
            "heading": "Something about how you keep busy. 💻",
            "question": "and I have knowledge of",
            "hint_text": "Select Options",
            "fields": [
              "radio"
            ],
            "options": [
              {
                "text": "Figma",
                "value": "figma"
              },
              {
                "text": "AdobeXD",
                "value": "adobe xd"
              }
            ],
            "ans": null
          }
        ]
      }
    }
  ]
};