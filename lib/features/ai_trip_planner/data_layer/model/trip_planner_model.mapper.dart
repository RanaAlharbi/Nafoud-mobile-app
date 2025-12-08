// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'trip_planner_model.dart';

class TripModelMapper extends ClassMapperBase<TripModel> {
  TripModelMapper._();

  static TripModelMapper? _instance;
  static TripModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TripModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TripModel';

  static String? _$destination(TripModel v) => v.destination;
  static const Field<TripModel, String> _f$destination = Field(
    'destination',
    _$destination,
    opt: true,
  );
  static TravelerType? _$travelerType(TripModel v) => v.travelerType;
  static const Field<TripModel, TravelerType> _f$travelerType = Field(
    'travelerType',
    _$travelerType,
    opt: true,
  );
  static int? _$adults(TripModel v) => v.adults;
  static const Field<TripModel, int> _f$adults = Field(
    'adults',
    _$adults,
    opt: true,
  );
  static int? _$kids(TripModel v) => v.kids;
  static const Field<TripModel, int> _f$kids = Field('kids', _$kids, opt: true);
  static DateTimeRange<DateTime>? _$dateRange(TripModel v) => v.dateRange;
  static const Field<TripModel, DateTimeRange<DateTime>> _f$dateRange = Field(
    'dateRange',
    _$dateRange,
    opt: true,
  );
  static List<String> _$assistanceNeeded(TripModel v) => v.assistanceNeeded;
  static const Field<TripModel, List<String>> _f$assistanceNeeded = Field(
    'assistanceNeeded',
    _$assistanceNeeded,
    opt: true,
  );
  static BudgetTier? _$budget(TripModel v) => v.budget;
  static const Field<TripModel, BudgetTier> _f$budget = Field(
    'budget',
    _$budget,
    opt: true,
  );
  static List<String> _$interests(TripModel v) => v.interests;
  static const Field<TripModel, List<String>> _f$interests = Field(
    'interests',
    _$interests,
    opt: true,
  );

  @override
  final MappableFields<TripModel> fields = const {
    #destination: _f$destination,
    #travelerType: _f$travelerType,
    #adults: _f$adults,
    #kids: _f$kids,
    #dateRange: _f$dateRange,
    #assistanceNeeded: _f$assistanceNeeded,
    #budget: _f$budget,
    #interests: _f$interests,
  };

  static TripModel _instantiate(DecodingData data) {
    return TripModel(
      destination: data.dec(_f$destination),
      travelerType: data.dec(_f$travelerType),
      adults: data.dec(_f$adults),
      kids: data.dec(_f$kids),
      dateRange: data.dec(_f$dateRange),
      assistanceNeeded: data.dec(_f$assistanceNeeded),
      budget: data.dec(_f$budget),
      interests: data.dec(_f$interests),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static TripModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TripModel>(map);
  }

  static TripModel fromJson(String json) {
    return ensureInitialized().decodeJson<TripModel>(json);
  }
}

mixin TripModelMappable {
  String toJson() {
    return TripModelMapper.ensureInitialized().encodeJson<TripModel>(
      this as TripModel,
    );
  }

  Map<String, dynamic> toMap() {
    return TripModelMapper.ensureInitialized().encodeMap<TripModel>(
      this as TripModel,
    );
  }

  TripModelCopyWith<TripModel, TripModel, TripModel> get copyWith =>
      _TripModelCopyWithImpl<TripModel, TripModel>(
        this as TripModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TripModelMapper.ensureInitialized().stringifyValue(
      this as TripModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return TripModelMapper.ensureInitialized().equalsValue(
      this as TripModel,
      other,
    );
  }

  @override
  int get hashCode {
    return TripModelMapper.ensureInitialized().hashValue(this as TripModel);
  }
}

extension TripModelValueCopy<$R, $Out> on ObjectCopyWith<$R, TripModel, $Out> {
  TripModelCopyWith<$R, TripModel, $Out> get $asTripModel =>
      $base.as((v, t, t2) => _TripModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TripModelCopyWith<$R, $In extends TripModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get assistanceNeeded;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get interests;
  $R call({
    String? destination,
    TravelerType? travelerType,
    int? adults,
    int? kids,
    DateTimeRange<DateTime>? dateRange,
    List<String>? assistanceNeeded,
    BudgetTier? budget,
    List<String>? interests,
  });
  TripModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TripModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TripModel, $Out>
    implements TripModelCopyWith<$R, TripModel, $Out> {
  _TripModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TripModel> $mapper =
      TripModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get assistanceNeeded => ListCopyWith(
    $value.assistanceNeeded,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(assistanceNeeded: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get interests =>
      ListCopyWith(
        $value.interests,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(interests: v),
      );
  @override
  $R call({
    Object? destination = $none,
    Object? travelerType = $none,
    Object? adults = $none,
    Object? kids = $none,
    Object? dateRange = $none,
    Object? assistanceNeeded = $none,
    Object? budget = $none,
    Object? interests = $none,
  }) => $apply(
    FieldCopyWithData({
      if (destination != $none) #destination: destination,
      if (travelerType != $none) #travelerType: travelerType,
      if (adults != $none) #adults: adults,
      if (kids != $none) #kids: kids,
      if (dateRange != $none) #dateRange: dateRange,
      if (assistanceNeeded != $none) #assistanceNeeded: assistanceNeeded,
      if (budget != $none) #budget: budget,
      if (interests != $none) #interests: interests,
    }),
  );
  @override
  TripModel $make(CopyWithData data) => TripModel(
    destination: data.get(#destination, or: $value.destination),
    travelerType: data.get(#travelerType, or: $value.travelerType),
    adults: data.get(#adults, or: $value.adults),
    kids: data.get(#kids, or: $value.kids),
    dateRange: data.get(#dateRange, or: $value.dateRange),
    assistanceNeeded: data.get(#assistanceNeeded, or: $value.assistanceNeeded),
    budget: data.get(#budget, or: $value.budget),
    interests: data.get(#interests, or: $value.interests),
  );

  @override
  TripModelCopyWith<$R2, TripModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TripModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

