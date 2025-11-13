enum MenuEntryActionType {
  navigation,
  toggle,
}

enum MenuEntrySymbol {
  documents,
  pendingDocuments,
  finance,
  events,
  courses,
  tracks,
  notes,
  learningMap,
  certificates,
  focusMode,
}

class MenuEntryModel {
  final String id;
  final String label;
  final String? caption;
  final MenuEntrySymbol symbol;
  final MenuEntryActionType actionType;
  final String capabilityReference;
  final bool isToggleOn;

  const MenuEntryModel({
    required this.id,
    required this.label,
    this.caption,
    required this.symbol,
    required this.actionType,
    required this.capabilityReference,
    this.isToggleOn = false,
  });

  MenuEntryModel copyWith({
    String? label,
    String? caption,
    MenuEntrySymbol? symbol,
    MenuEntryActionType? actionType,
    String? capabilityReference,
    bool? isToggleOn,
  }) {
    return MenuEntryModel(
      id: id,
      label: label ?? this.label,
      caption: caption ?? this.caption,
      symbol: symbol ?? this.symbol,
      actionType: actionType ?? this.actionType,
      capabilityReference: capabilityReference ?? this.capabilityReference,
      isToggleOn: isToggleOn ?? this.isToggleOn,
    );
  }
}
