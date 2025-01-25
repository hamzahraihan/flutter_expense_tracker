// Think of the Repository as a tool that you can perform
// CRUD operations (Create, Read, Update, Delete) on.
// Repositories in the domain layer do not specify how the
// data is actually stored or retrieved, they just define
// what you can do with the data.

import 'package:expense_tracker/features/auth/domain/entity/auth_entities.dart';

abstract class AuthRepository {
  Stream<AuthEntities> get authUser;

  Future<AuthEntities> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<AuthEntities> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
}

// This is crucial for the Clean Architecture's goal of separation
// of concerns and making the system more flexible and adaptable.
// If you want to change how the data is stored - say, moving
// from a relational database to a NoSQL database, or even
// to an in-memory database for testing - you can do so
// by implementing a new Repository that adheres to the same
// interface, without having to change your application's core logic.

// The main role of a Repository is to hide the details of how data
// for the entities is fetched or stored. It provides a clean API
// for the rest of the application to obtain domain entities without needing to know
// where they come from or what type of infrastructure is used to store them.
