// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chatbot_model.dart';

class ChatbotConfigModelMapper extends ClassMapperBase<ChatbotConfigModel> {
  ChatbotConfigModelMapper._();

  static ChatbotConfigModelMapper? _instance;
  static ChatbotConfigModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatbotConfigModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatbotConfigModel';

  static const Field<ChatbotConfigModel, String> _f$apiKey = Field(
    'apiKey',
    null,
    mode: FieldMode.param,
  );
  static const Field<ChatbotConfigModel, String> _f$model = Field(
    'model',
    null,
    mode: FieldMode.param,
  );
  static const Field<ChatbotConfigModel, String> _f$systemInstruction = Field(
    'systemInstruction',
    null,
    mode: FieldMode.param,
  );
  static const Field<ChatbotConfigModel, String> _f$welcomeMessage = Field(
    'welcomeMessage',
    null,
    mode: FieldMode.param,
  );

  @override
  final MappableFields<ChatbotConfigModel> fields = const {
    #apiKey: _f$apiKey,
    #model: _f$model,
    #systemInstruction: _f$systemInstruction,
    #welcomeMessage: _f$welcomeMessage,
  };

  static ChatbotConfigModel _instantiate(DecodingData data) {
    return ChatbotConfigModel(
      apiKey: data.dec(_f$apiKey),
      model: data.dec(_f$model),
      systemInstruction: data.dec(_f$systemInstruction),
      welcomeMessage: data.dec(_f$welcomeMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatbotConfigModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatbotConfigModel>(map);
  }

  static ChatbotConfigModel fromJson(String json) {
    return ensureInitialized().decodeJson<ChatbotConfigModel>(json);
  }
}

mixin ChatbotConfigModelMappable {
  String toJson() {
    return ChatbotConfigModelMapper.ensureInitialized()
        .encodeJson<ChatbotConfigModel>(this as ChatbotConfigModel);
  }

  Map<String, dynamic> toMap() {
    return ChatbotConfigModelMapper.ensureInitialized()
        .encodeMap<ChatbotConfigModel>(this as ChatbotConfigModel);
  }

  ChatbotConfigModelCopyWith<
    ChatbotConfigModel,
    ChatbotConfigModel,
    ChatbotConfigModel
  >
  get copyWith =>
      _ChatbotConfigModelCopyWithImpl<ChatbotConfigModel, ChatbotConfigModel>(
        this as ChatbotConfigModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ChatbotConfigModelMapper.ensureInitialized().stringifyValue(
      this as ChatbotConfigModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatbotConfigModelMapper.ensureInitialized().equalsValue(
      this as ChatbotConfigModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatbotConfigModelMapper.ensureInitialized().hashValue(
      this as ChatbotConfigModel,
    );
  }
}

extension ChatbotConfigModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatbotConfigModel, $Out> {
  ChatbotConfigModelCopyWith<$R, ChatbotConfigModel, $Out>
  get $asChatbotConfigModel => $base.as(
    (v, t, t2) => _ChatbotConfigModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatbotConfigModelCopyWith<
  $R,
  $In extends ChatbotConfigModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    required String apiKey,
    required String model,
    required String systemInstruction,
    required String welcomeMessage,
  });
  ChatbotConfigModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatbotConfigModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatbotConfigModel, $Out>
    implements ChatbotConfigModelCopyWith<$R, ChatbotConfigModel, $Out> {
  _ChatbotConfigModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatbotConfigModel> $mapper =
      ChatbotConfigModelMapper.ensureInitialized();
  @override
  $R call({
    required String apiKey,
    required String model,
    required String systemInstruction,
    required String welcomeMessage,
  }) => $apply(
    FieldCopyWithData({
      #apiKey: apiKey,
      #model: model,
      #systemInstruction: systemInstruction,
      #welcomeMessage: welcomeMessage,
    }),
  );
  @override
  ChatbotConfigModel $make(CopyWithData data) => ChatbotConfigModel(
    apiKey: data.get(#apiKey),
    model: data.get(#model),
    systemInstruction: data.get(#systemInstruction),
    welcomeMessage: data.get(#welcomeMessage),
  );

  @override
  ChatbotConfigModelCopyWith<$R2, ChatbotConfigModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatbotConfigModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

