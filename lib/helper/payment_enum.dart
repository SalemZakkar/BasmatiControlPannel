String getPaymentStatus(String state) {
  switch (state) {
    case "Pending payment":
      return "بانتظار عملية الدفع";
    case "Payment canceled":
      return "ملغية";
    case "Accepted":
      return "مقبولة";
    case "Payment failed":
      return "فشل الدفع";
    case "Pending":
      return "معلقة";
    case "Dropped":
      return "مستبعدة";
    case "Rejected":
      return "مرفوضة";
    case "Auto rejected":
      return "مرفوضة تلقائياً";
    case "Canceled":
      return "ملغية";
    case "Done":
      return "مدفوعة";
    default:
      return "";
  }
}
