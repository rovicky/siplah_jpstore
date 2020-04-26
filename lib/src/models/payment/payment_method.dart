import 'package:siplah_jpmall/src/utils/base_url.dart';

class PaymentMethod {
  final String url;
  final String type;
  final String bankName;
  final String displayName;

  PaymentMethod(this.displayName, {this.url, this.type, this.bankName});

}

List<PaymentMethod> listPayment = [
  PaymentMethod("Bank Bca",url: BaseUrl.baseAssets + "images/payment/bca.png", bankName: "bca", type: "bank_tranfer"),
  PaymentMethod("Bank Mandiri",url: BaseUrl.baseAssets + "images/payment/mandiri.png", bankName: "mandiri", type: "bank_tranfer"),
  PaymentMethod("Bank Bni", url: BaseUrl.baseAssets + "images/payment/bni.png", bankName: "bni", type: "bank_tranfer"),
  PaymentMethod("BCA Klik Pay", url: null, bankName: "bca_klikpay", type: "internet_banking"),
  PaymentMethod("Klik BCA", url: BaseUrl.baseAssets + "images/payment/klik_bca.png", bankName: "bca_klikbca", type: "internet_banking"),
  PaymentMethod("Mandiri ClickPay", url: BaseUrl.baseAssets + "images/payment/mandiri_clickpay.png", bankName: "mandiri_clickpay", type: "internet_banking"),
  PaymentMethod("Indomaret", url: null, bankName: "Indomaret", type: "cstore"),
  PaymentMethod("Alfamart", url: BaseUrl.baseAssets + "images/payment/alfamart.png", bankName: "alfamart", type: "cstore"),
];