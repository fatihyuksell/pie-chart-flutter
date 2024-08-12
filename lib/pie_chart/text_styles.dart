import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TextStyles extends ThemeExtension<TextStyles> with EquatableMixin {
  final TextStyle body;
  final TextStyle body2;
  final TextStyle body3;
  final TextStyle sectionTitle3;
  final TextStyle caption;
  final TextStyle caption2;
  final TextStyle caption3;
  final TextStyle subtitle;
  final TextStyle subtitle2;
  final TextStyle subtitle3;
  final TextStyle subtitle4;
  final TextStyle link;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle button;
  final TextStyle title;
  final TextStyle successTitle;
  final TextStyle amountTextField;
  final TextStyle cardNumber;

  const TextStyles({
    required this.body,
    required this.body2,
    required this.body3,
    required this.sectionTitle3,
    required this.caption,
    required this.subtitle,
    required this.subtitle2,
    required this.link,
    required this.title1,
    required this.title2,
    required this.button,
    required this.title,
    required this.successTitle,
    required this.amountTextField,
    required this.cardNumber,
    required this.subtitle3,
    required this.subtitle4,
    required this.caption2,
    required this.caption3,
  });

  @override
  ThemeExtension<TextStyles> lerp(ThemeExtension<TextStyles>? other, double t) {
    return this;
  }

  @override
  TextStyles copyWith({
    TextStyle? body,
    TextStyle? body2,
    TextStyle? body3,
    TextStyle? sectionTitle3,
    TextStyle? caption,
    TextStyle? subtitle,
    TextStyle? subtitle2,
    TextStyle? subtitle3,
    TextStyle? link,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? button,
    TextStyle? title,
    TextStyle? successTitle,
    TextStyle? amountTextField,
    TextStyle? cardNumber,
    TextStyle? subtitle4,
    TextStyle? caption2,
    TextStyle? caption3,
  }) {
    return TextStyles(
      body: body ?? this.body,
      body2: body2 ?? this.body2,
      body3: body3 ?? this.body3,
      sectionTitle3: sectionTitle3 ?? this.sectionTitle3,
      caption: caption ?? this.caption,
      subtitle: subtitle ?? this.subtitle,
      subtitle2: subtitle2 ?? this.subtitle2,
      link: link ?? this.link,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      button: button ?? this.button,
      title: title ?? this.title,
      successTitle: successTitle ?? this.successTitle,
      amountTextField: amountTextField ?? this.amountTextField,
      cardNumber: cardNumber ?? this.cardNumber,
      subtitle3: subtitle3 ?? this.subtitle3,
      subtitle4: subtitle4 ?? this.subtitle4,
      caption2: caption2 ?? this.caption2,
      caption3: caption3 ?? this.caption3,
    );
  }

  @override
  List<Object> get props {
    return [
      body,
      body2,
      body3,
      sectionTitle3,
      caption,
      subtitle,
      subtitle2,
      subtitle3,
      link,
      title1,
      title2,
      button,
      title,
      successTitle,
      amountTextField,
      cardNumber,
      subtitle4,
      caption2,
      caption3,
    ];
  }

  factory TextStyles.light() => const TextStyles(
        body: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        body2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        body3: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        title: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        sectionTitle3: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        caption: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        caption2: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        caption3: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        subtitle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        subtitle2: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        subtitle3: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
        subtitle4: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 23,
        ),
        link: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        title1: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        title2: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
        ),
        successTitle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        button: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        amountTextField: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        cardNumber: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      );
}
