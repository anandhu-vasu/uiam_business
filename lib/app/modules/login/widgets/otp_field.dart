import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldStyle { underline, box }

class OtpFieldStyle {
  /// The background color for outlined box.
  final Color backgroundColor;

  /// The border color text field.
  final Color borderColor;

  /// The border color of text field when in focus.
  final Color focusBorderColor;

  /// The border color of text field when disabled.
  final Color disabledBorderColor;

  /// The border color of text field when in focus.
  final Color enabledBorderColor;

  /// The border color of text field when disabled.
  final Color errorBorderColor;

  OtpFieldStyle(
      {this.backgroundColor: Colors.transparent,
      this.borderColor: Colors.black26,
      this.focusBorderColor: Colors.blue,
      this.disabledBorderColor: Colors.grey,
      this.enabledBorderColor: Colors.black26,
      this.errorBorderColor: Colors.red});
}

class OTPTextField extends StatefulWidget {
  /// TextField Controller
  final OtpFieldController? controller;

  /// Number of the OTP Fields
  final int length;

  /// Total Width of the OTP Text Field
  final double width;

  /// Width of the single OTP Field
  final double fieldWidth;

  /// margin around the text fields
  @Deprecated(
      "Since there is an issue with the margin because it's around each item, we use [spaceBetween] from now on.")
  final EdgeInsetsGeometry? margin;

  /// space between the text fields
  final double spaceBetween;

  /// content padding of the text fields
  final EdgeInsets contentPadding;

  /// Manage the type of keyboard that shows up
  final TextInputType keyboardType;

  /// show the error border or not
  final bool hasError;

  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  final TextStyle style;

  /// The style to use for the text being edited.
  final double outlineBorderRadius;

  /// Text Field Alignment
  /// default: MainAxisAlignment.spaceBetween [MainAxisAlignment]
  final MainAxisAlignment textFieldAlignment;

  /// Obscure Text if data is sensitive
  final bool obscureText;

  /// Whether the [InputDecorator.child] is part of a dense form (i.e., uses less vertical
  /// space).
  final bool isDense;

// TODO: Review the following properties
  /// Text Field Style
  final OtpFieldStyle? otpFieldStyle;

  // /// Text Field Style for field shape.
  // /// default FieldStyle.underline [FieldStyle]
  final FieldStyle fieldStyle;

  /// Callback function, called when a change is detected to the pin.
  final ValueChanged<String>? onChanged;

  /// Callback function, called when pin is completed.
  final ValueChanged<String>? onCompleted;

  final List<TextInputFormatter>? inputFormatter;

  final Widget Function(Widget)? parent;

  const OTPTextField({
    Key? key,
    this.length = 4,
    this.width = 10,
    this.controller,
    this.fieldWidth = 30,
    this.spaceBetween = 0,
    this.otpFieldStyle,
    this.hasError = false,
    this.margin,
    this.keyboardType = TextInputType.number,
    this.style = const TextStyle(),
    this.outlineBorderRadius: 10,
    this.textCapitalization = TextCapitalization.none,
    this.textFieldAlignment = MainAxisAlignment.spaceBetween,
    this.obscureText = false,
    this.fieldStyle = FieldStyle.underline,
    this.onChanged,
    this.inputFormatter,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    this.isDense = false,
    this.onCompleted,
    this.parent,
  })  : assert(length > 1),
        super(key: key);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  late OtpFieldStyle _otpFieldStyle;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  late List<String> _pin;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!.setOtpTextFieldState(this);
    }

    if (widget.otpFieldStyle == null) {
      _otpFieldStyle = OtpFieldStyle();
    } else {
      _otpFieldStyle = widget.otpFieldStyle!;
    }

    _focusNodes = List<FocusNode?>.filled(widget.length, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.length, null,
        growable: false);

    _pin = List.generate(widget.length, (int i) {
      return '';
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((controller) => controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          return buildTextField(context, index);
        }),
      ),
    );
  }

  /// This function Build and returns individual TextField item.
  ///
  /// * Requires a build context
  /// * Requires Int position of the field
  Widget buildTextField(BuildContext context, int index) {
    if (_focusNodes[index] == null) _focusNodes[index] = FocusNode();

    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();
    }
    final isLast = index == widget.length - 1;

    InputBorder _getBorder(Color color) {
      final colorOrError =
          widget.hasError ? _otpFieldStyle.errorBorderColor : color;

      return widget.fieldStyle == FieldStyle.box
          ? OutlineInputBorder(
              borderSide: BorderSide(color: colorOrError),
              borderRadius: BorderRadius.circular(widget.outlineBorderRadius),
            )
          : UnderlineInputBorder(borderSide: BorderSide(color: colorOrError));
    }

    Widget textField() {
      return TextField(
        controller: _textControllers[index],
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textAlign: TextAlign.center,
        style: widget.style,
        inputFormatters: widget.inputFormatter,
        maxLength: 1,
        cursorColor: Colors.transparent,
        cursorWidth: 0,
        focusNode: _focusNodes[index],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          isDense: widget.isDense,
          filled: true,
          fillColor: _otpFieldStyle.backgroundColor,
          counterText: "",
          contentPadding: widget.contentPadding,
          border: _getBorder(_otpFieldStyle.borderColor),
          focusedBorder: _getBorder(_otpFieldStyle.focusBorderColor),
          enabledBorder: _getBorder(_otpFieldStyle.enabledBorderColor),
          disabledBorder: _getBorder(_otpFieldStyle.disabledBorderColor),
          errorBorder: _getBorder(_otpFieldStyle.errorBorderColor),
          focusedErrorBorder: _getBorder(_otpFieldStyle.errorBorderColor),
          errorText: null,
          // to hide the error text
          errorStyle: const TextStyle(height: 0, fontSize: 0),
        ),
        onTap: () {
          _textControllers[index]?.selection = TextSelection.fromPosition(
              TextPosition(offset: _textControllers[index]?.text.length ?? 0));
        },
        onChanged: (String str) {
          if (str.length > 1) {
            _handlePaste(str);
            return;
          }

          // Check if the current value at this position is empty
          // If it is move focus to previous text field.
          if (str.isEmpty) {
            if (index == 0) return;
            _focusNodes[index]!.unfocus();
            _focusNodes[index - 1]!.requestFocus();
          }

          // Update the current pin
          setState(() {
            _pin[index] = str;
          });

          // Remove focus
          if (str.isNotEmpty) _focusNodes[index]!.unfocus();
          // Set focus to the next field if available
          if (index + 1 != widget.length && str.isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          String currentPin = _getCurrentPin();

          // if there are no null values that means otp is completed
          // Call the `onCompleted` callback function provided
          if (!_pin.contains(null) &&
              !_pin.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted?.call(currentPin);
          }

          // Call the `onChanged` callback function
          if (widget.onChanged != null) {
            widget.onChanged!(currentPin);
          }
        },
      );
    }

    return widget.parent == null
        ? Container(
            width: widget.fieldWidth,
            margin: widget.margin ??
                EdgeInsets.only(
                  right: isLast ? 0 : widget.spaceBetween,
                ),
            child: textField(),
          )
        : widget.parent!(textField());
  }

  String _getCurrentPin() {
    String currentPin = "";
    _pin.forEach((String value) {
      currentPin += value;
    });
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > widget.length) {
      str = str.substring(0, widget.length);
    }

    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers[i]!.text = digit;
      _pin[i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes[widget.length - 1]);

    String currentPin = _getCurrentPin();

    // if there are no null values that means otp is completed
    // Call the `onCompleted` callback function provided
    if (!_pin.contains(null) &&
        !_pin.contains('') &&
        currentPin.length == widget.length) {
      widget.onCompleted?.call(currentPin);
    }

    // Call the `onChanged` callback function
    widget.onChanged!(currentPin);
  }
}

class OtpFieldController {
  late final _OTPTextFieldState otpTextFieldState;

  void setOtpTextFieldState(_OTPTextFieldState state) {
    otpTextFieldState = state;
  }

  void clear() {
    print("||||||||||||||||||||||||||||||");
    print(otpTextFieldState);
    final textFieldLength = otpTextFieldState.widget.length;
    otpTextFieldState._pin = List.generate(textFieldLength, (int i) {
      return '';
    });

    final textControllers = otpTextFieldState._textControllers;
    textControllers.forEach((textController) {
      if (textController != null) {
        textController.text = '';
      }
    });

    final firstFocusNode = otpTextFieldState._focusNodes[0];
    if (firstFocusNode != null) {
      firstFocusNode.requestFocus();
    }
  }

  void set(List<String> pin) {
    final textFieldLength = otpTextFieldState.widget.length;
    if (pin.length < textFieldLength) {
      throw Exception(
          "Pin length must be same as field length. Expected: $textFieldLength, Found ${pin.length}");
    }

    otpTextFieldState._pin = pin;
    String newPin = '';

    final textControllers = otpTextFieldState._textControllers;
    for (int i = 0; i < textControllers.length; i++) {
      final textController = textControllers[i];
      final pinValue = pin[i];
      newPin += pinValue;

      if (textController != null) {
        textController.text = pinValue;
      }
    }

    final widget = otpTextFieldState.widget;

    widget.onChanged?.call(newPin);

    widget.onCompleted?.call(newPin);
  }

  void setValue(String value, int position) {
    final maxIndex = otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final textControllers = otpTextFieldState._textControllers;
    final textController = textControllers[position];
    final currentPin = otpTextFieldState._pin;

    if (textController != null) {
      textController.text = value;
      currentPin[position] = value;
    }

    String newPin = "";
    currentPin.forEach((item) {
      newPin += item;
    });

    final widget = otpTextFieldState.widget;
    if (widget.onChanged != null) {
      widget.onChanged!(newPin);
    }
  }

  void setFocus(int position) {
    final maxIndex = otpTextFieldState.widget.length - 1;
    if (position > maxIndex) {
      throw Exception(
          "Provided position is out of bounds for the OtpTextField");
    }

    final focusNodes = otpTextFieldState._focusNodes;
    final focusNode = focusNodes[position];

    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }
}
