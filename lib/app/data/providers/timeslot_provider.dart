import 'firestore_provider.dart';
import '../models/timeslot_model.dart';

class TimeslotProvider extends FirestoreProvider<TimeslotModel> {
  TimeslotProvider(String? docId) : super(docId);

  @override
  collectionRef() => FirestoreProvider.db.collection('timeslots');

  @override
  modelRef(documentSnapshot) =>
      TimeslotModel.fromDocumentSnapshot(documentSnapshot);
}
