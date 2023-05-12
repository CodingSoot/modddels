library modddels_annotation_internal;

export 'src/annotations/annotations.dart'
    show
        Modddel,
        ValidParamAnnotation,
        validParam,
        InvalidParamAnnotation,
        invalidParam,
        WithGetterAnnotation,
        withGetter,
        ValidWithGetterAnnotation,
        validWithGetter,
        InvalidWithGetterAnnotation,
        invalidWithGetter,
        NullFailure,
        DependencyParamAnnotation,
        dependencyParam,
        TypeTemplate;
export 'src/annotations/shared_props.dart' show SharedProp;
export 'src/annotations/validation.dart'
    show contentValidation, Validation, FailureType, ValidationStep;

export 'src/core/errors.dart' show UnreachableError;
export 'src/core/utils.dart' show ellipsize;

export 'src/modddels/failures.dart'
    show
        Failure,
        ValueFailure,
        EntityFailure,
        ContentFailure,
        ModddelInvalidMember;
export 'src/modddels/modddel_interfaces.dart'
    show
        ValidModddel,
        ValidValueObject,
        ValidEntity,
        InvalidModddel,
        InvalidValueObject,
        InvalidEntity;
