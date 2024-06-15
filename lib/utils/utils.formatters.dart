part of 'utils.dart';

class _Formatters {
  const _Formatters();
  // TextInputFormatter get phone {
  //   return MaskTextInputFormatter(
  //     mask: '## ### ####',
  //     filter: {'#': RegExp('[0-9]')},
  //   );
  // }

  // TextInputFormatter get creditCard {
  //   return MaskTextInputFormatter(
  //     mask: '#### #### #### ####',
  //     filter: {'#': RegExp('[0-9]')},
  //   );
  // }

  // TextInputFormatter get monthYear {
  //   return MaskTextInputFormatter(
  //     mask: '##/##',
  //     filter: {'#': RegExp('[0-9]')},
  //   );
  // }

  // TextInputFormatter get iban {
  //   return MaskTextInputFormatter(
  //     mask: '## #### #### #### #### #### #',
  //     filter: {'#': RegExp('[0-9]')},
  //   );
  // }

  ///  15.35 TL gibi max 2 haneli girebiliyor
  TextInputFormatter get onlyTwoDecimalDigits {
    return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
  }

  TextInputFormatter get digitsOnly => FilteringTextInputFormatter.digitsOnly;
}
