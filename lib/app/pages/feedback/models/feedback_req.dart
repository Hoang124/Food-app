class FeedbackRequest {
  int? foodId;
  String? comment;
  int? rate;
  FeedbackRequest({
    this.comment,
    this.foodId,
    this.rate,
  });
  Map<String, dynamic> toJson() {
    return {
      "foodId": foodId,
      "comment": comment,
      "rate": rate,
    };
  }
}
