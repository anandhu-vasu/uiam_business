import '../models/business_model.dart';
import 'firestore_provider.dart';

class BusinessProvider extends FirestoreProvider<BusinessModel> {
  BusinessProvider(String? docId) : super(docId);

  @override
  collectionRef() => FirestoreProvider.db.collection('businesses');

  @override
  modelRef(documentSnapshot) =>
      BusinessModel.fromDocumentSnapshot(documentSnapshot);
}
