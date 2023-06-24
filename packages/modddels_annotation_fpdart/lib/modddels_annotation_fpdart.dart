library modddels_annotation_fpdart;

export 'package:modddels_annotation_internal/modddels_annotation_internal.dart'
    show
        Modddel,
        validParam,
        invalidParam,
        withGetter,
        validWithGetter,
        invalidWithGetter,
        NullFailure,
        dependencyParam,
        TypeTemplate,
        SharedProp,
        contentValidation,
        Validation,
        FailureType,
        ValidationStep,
        UnreachableError,
        Failure,
        ValueFailure,
        EntityFailure,
        ContentFailure,
        ModddelInvalidMember,
        ValidModddel,
        ValidValueObject,
        ValidEntity,
        InvalidModddel,
        InvalidValueObject,
        InvalidEntity;

export 'package:fpdart/fpdart.dart';
export 'package:test/test.dart';

export 'src/modddels/base_modddel.dart' show BaseModddel;
export 'src/modddels/value_objects/value_objects.dart'
    show ValueObject, SingleValueObject, MultiValueObject;
export 'src/modddels/entities/entity.dart' show Entity;
export 'src/modddels/entities/simple_entity/simple_entity.dart'
    show SimpleEntity;
export 'src/modddels/entities/iterables_entities/iterable_entity.dart'
    show
        IterableEntity,
        ListEntity,
        KtListEntity,
        IListEntity,
        SetEntity,
        KtSetEntity,
        ISetEntity,
        MappedValuesEntity,
        KtMappedValuesEntity,
        IMappedValuesEntity,
        MappedKeysEntity,
        KtMappedKeysEntity,
        IMappedKeysEntity;
export 'src/modddels/entities/iterables_entities/iterable2_entity.dart'
    show Iterable2Entity, MapEntity, KtMapEntity, IMapEntity;

export 'src/unit_testing/base_tester.dart' show BaseTester;
export 'src/unit_testing/unit_testing_classes.dart'
    show InvalidStepTest, ModddelParams;
