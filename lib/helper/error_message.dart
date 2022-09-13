String errorParse(String codeError) {
  switch (codeError) {
    case "0602":
      // return "Invalid authentication email or password.";
      return "خطأ في البريد الإلكتروني او كلمة المرور";
    case "7":
      return "لا يوجد إتصال بالإنترنت";
    case "0000":
      return "لا يوجد إتصال بالإنترنت";
    case "0601":
      return "يرجى تسجيل الدخول";
    case "0603":
      // return "Invalid authentication phone or password.";
      return "خطأ في رقم الهاتف او كلمة المرور";
    case "0605":
      // return "Invalid authentication phone or code.";
      return "هاتف مصادقة غير صالح أو رمز.";
    case "0625":
      // return "Can not access because account is not verified.";
      return "يرجى استكمال عملية التحقق";
    case "0626":
      // return "Can not access because account has been deactivated.";
      return "تم حظر حسابك";
    case "0627":
      // return "User profile is incomplete.";
      return "ملف تعريف المستخدم غير مكتمل.";

    case "0660":
      // return "Invalid old password.";
      return "كلمة مرور قديمة غير صحيحة.";
    case "0661":
      // return "Account already verified.";
      return "الحساب تم التحقق منه بالفعل.";
    case "0662":
      // return "Account already active.";
      return "حساب نشط بالفعل.";
    case "0663":
      // return "Account already inactive.";
      return "حساب غير نشط بالفعل.";
    case "0664":
      // return "Too many attempts.";
      return "محاولات كثيرة.";
    case "0401":
      // return "File not found.";
      return "لم يتم العثور على الملف.";
    case "0402":
      // return "Error uploading file.";
      return "خطأ في تحميل ملف.";
    case "0701":
      return "stripe: undefined";
    // return "";
    case "0702":
      return "'lorem ipsum'";
    // return "";
    case "0703":
      // return "Payment amount must be greater then 0 and less then 1,000,000 .";
      return "يجب أن يكون مبلغ الدفع أكبر من 0 وأقل من 1،000،000.";
    case "0201":
      // return "Request validation error";
      return "خطأ في البيانات";
    case "1101":
      // return "User not found.";
      return "المستخدم غير موجود.";
    case "1102":
      // return "Invalid validation code.";
      return "رمز التحقق غير صحيح.";
    case "1103":
      // return "Supervisor not found.";
      return "المشرف غير موجود.";
    case "1104":
      // return "Can not delete active user.";
      return "لا يمكن حذف المستخدم النشط.";
    case "1201":
      // return "Product not found.";
      return "الصنف غير موجود.";
    case "0620":
      return "ليس لديك اذن";
    case "0640":
      return "ليس لديك اذن";
    case "0301":
      return "المعلومات موجودة مسبقا";

    default:
      // return "Please again later...";
      return "الرجاء المحاولة لاحقا...";
  }
}
