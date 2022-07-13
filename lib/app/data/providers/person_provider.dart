import 'firestore_provider.dart';
import '../models/person_model.dart';

class PersonProvider extends FirestoreProvider<PersonModel> {
  PersonProvider(String? docId) : super(docId);

  @override
  collectionRef() => FirestoreProvider.db.collection('persons');

  @override
  modelRef(documentSnapshot) =>
      PersonModel.fromDocumentSnapshot(documentSnapshot);
}
