import 'package:uiam_business/app/data/models/appointment_model.dart';

import 'firestore_provider.dart';

class AppointmentProvider extends FirestoreProvider<AppointmentModel> {
  AppointmentProvider(String? docId) : super(docId);

  @override
  collectionRef() => FirestoreProvider.db.collection('appointments');

  @override
  modelRef(documentSnapshot) =>
      AppointmentModel.fromDocumentSnapshot(documentSnapshot);
}
