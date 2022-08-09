import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/material.dart';

extension RepositoryExtension on Repository {
  RepositoryScope _getScope<E extends Entity>([E? entity]) {
    if (E == Entity) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('Type argument not provided.'),
        ErrorHint(
          'You called a Repository method without providing Flutter a way to determine which type '
          'of Entity you are dealing with.',
        ),
        ErrorHint(
          'You can fix this by providing a type argument (i.e. "<ExampleEntity>") between the method call '
          'and the parameters, for example: '
          'repository.runService<ExampleEntity>(adapter, subscription)',
        ),
      ]);
    }
    RepositoryScope? repositoryScope = containsScope<E>();
    if (repositoryScope == null && entity != null) {
      repositoryScope = create<E>(entity, (_) {});
    }
    if (repositoryScope != null) {
      return repositoryScope;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary('Entity does not exist.'),
      ErrorDescription('There is no $E in the Repository yet.'),
      ErrorHint(
        'This happens when you call a Repository extension when $E does not exist in the '
        'Repository. The extension cannot do it\'s job without an Entity to use.',
      ),
      ErrorHint(
        'Usually, this does not happen because the entity has already been set before this point. '
        'This error is an indication that this is not the case, such as when this call is made early '
        'in the FeatureWidget\'s lifetime.',
      ),
      ErrorHint(
        'You can fix this error rather easily by setting the Entity just before this call, '
        'or ensuring it is set at some time closer to Widget creation time.',
      ),
      ErrorHint(
        'If this happened when calling "getEntity", you can provide an instance of the entity you '
        'are trying to get as a parameter that will be used in case it does not exist yet.',
      )
    ]);
  }

  /// Example usage with entity instance:
  ///
  /// var entity = repo().getEntity(ExampleEntity());
  ///
  /// This version guarantees the entity will be returned with no errors. It is
  /// recommended you use this version when possible. If the entity you are
  /// trying to fetch does not exist yet, the entity you provide as a parameter
  /// will be used to set it.
  ///
  /// Example usage with type argument:
  ///
  /// var entity = repo().getEntity<ExampleEntity>();
  ///
  /// This version will throw an error if the entity does not exist in the
  /// repository yet. It should only be used when the Entity constructor
  /// requires parameters that you are unable to provide.

  E getEntity<E extends Entity>([E? entity]) {
    RepositoryScope repositoryScope = _getScope<E>(entity);
    return get<E>(repositoryScope);
  }

  /// Example usage:
  ///
  /// repo().updateEntity(entityInstance);

  void updateEntity<E extends Entity>(E entity) {
    RepositoryScope repositoryScope = _getScope(entity);
    update<E>(repositoryScope, entity);
  }

  /// Example without a subscription:
  ///
  /// repo().runService(_exampleServiceAdapter, entity: ExampleEntity());
  ///
  /// Example with subscription:
  ///
  /// repo().runService<ExampleEntity>(_exampleServiceAdapter,
  ///   entity: ExampleEntity(), subscription: _exampleSubscriberMethod);
  ///
  /// In the rare case you cannot provide an instance of the Entity, such as if
  /// it requires defaults you cannot provide, then provide only the type
  /// argument instead:
  ///
  /// repo().runService<ExampleEntity>(_exampleServiceAdapter);
  ///
  /// However, an error will be thrown if the relevant entity is not in the
  /// repository yet.

  Future<void> runService<E extends Entity>(
    ServiceAdapter serviceAdapter, {
    E? entity,
    Function(E)? subscription,
  }) async {
    RepositoryScope? repositoryScope = _getScope<E>(entity);

    repositoryScope.subscription = (entity) {
      repositoryScope.subscription = (_) {};
      if (subscription != null) {
        subscription(entity as E);
      }
    };

    await runServiceAdapter(repositoryScope, serviceAdapter);
  }
}
