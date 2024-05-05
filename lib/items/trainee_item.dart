import 'package:inka_test/models/Trainee.dart';

class TraineeItem {
  final String? firstName;
  final String? lastName;
  final String id; 
  final String? traineePhoto; 





  TraineeItem(
      {required this.firstName,
      required this.lastName,
      required this.id,
      required this.traineePhoto,
    });

     factory TraineeItem.fromTrainee(Trainee trainee) {
    return TraineeItem(
      firstName: trainee.firstName,
      lastName: trainee.lastName,
      traineePhoto: trainee.traineePhoto, id: ''
    );
  }

}