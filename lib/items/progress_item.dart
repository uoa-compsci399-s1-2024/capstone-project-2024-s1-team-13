class ProgressItem {
  final String title;
  final double progress;
  final int evaluationCount;
  final String feedback;
  final String notes;

  ProgressItem(this.title, this.progress, this.evaluationCount, this.feedback,
      this.notes);
}

// This class would probably need to be an extension of the trainee class.