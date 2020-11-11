abstract class BaseModel {
  String validString(String text) {
    if (text == null) return "";

    return text.trim();
  }
}
