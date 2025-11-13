import 'package:belluga_boilerplate/domain/menu/menu_entry_model.dart';
import 'package:belluga_boilerplate/domain/repositories/auth_repository_contract.dart';
import 'package:belluga_boilerplate/domain/user/user_belluga.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_value/core/stream_value.dart';

class MenuScreenController {
  MenuScreenController();

  final _authRepository = GetIt.I.get<AuthRepositoryContract>();

  final menuEntriesStreamValue = StreamValue<List<MenuEntryModel>>(
    defaultValue: const [],
  );

  StreamValue<UserBelluga?> get userStreamValue =>
      _authRepository.userStreamValue as StreamValue<UserBelluga?>;

  Future<void> init() async {
    menuEntriesStreamValue.addValue(_buildEntries());
  }

  void updateFocusMode(bool isEnabled) {
    final existingEntries = menuEntriesStreamValue.value;
    if (existingEntries.isEmpty) {
      return;
    }

    final currentEntries = [...existingEntries];
    final focusIndex = currentEntries
        .indexWhere((entry) => entry.symbol == MenuEntrySymbol.focusMode);

    if (focusIndex == -1) {
      return;
    }

    final updated = currentEntries[focusIndex].copyWith(isToggleOn: isEnabled);
    currentEntries[focusIndex] = updated;
    menuEntriesStreamValue.addValue(currentEntries);
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }

  List<MenuEntryModel> _buildEntries() {
    return const [
      MenuEntryModel(
        id: 'documents',
        label: 'Meus Documentos',
        caption: 'Comprovantes e acordos emitidos',
        symbol: MenuEntrySymbol.documents,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'documentation_engine.records',
      ),
      MenuEntryModel(
        id: 'pending_documents',
        label: 'Documentos Pendentes',
        caption: 'Envios e assinaturas em aberto',
        symbol: MenuEntrySymbol.pendingDocuments,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'documentation_engine.pending_items',
      ),
      MenuEntryModel(
        id: 'finance',
        label: 'Financeiro',
        caption: 'Faturas, cashback e plano',
        symbol: MenuEntrySymbol.finance,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'comercial_engine.billing',
      ),
      MenuEntryModel(
        id: 'events',
        label: 'Eventos',
        caption: 'Agenda e convites do tenant',
        symbol: MenuEntrySymbol.events,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'event_management_engine.events',
      ),
      MenuEntryModel(
        id: 'courses',
        label: 'Meus Cursos',
        caption: 'Acesse o catálogo matriculado',
        symbol: MenuEntrySymbol.courses,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'learning_engine.course_instances',
      ),
      MenuEntryModel(
        id: 'tracks',
        label: 'Trilhas da Unifast',
        caption: 'Percursos recomendados',
        symbol: MenuEntrySymbol.tracks,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'learning_engine.fast_tracks',
      ),
      MenuEntryModel(
        id: 'notes',
        label: 'Anotações',
        caption: 'Bloco inteligente de estudos',
        symbol: MenuEntrySymbol.notes,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'learning_engine.notes',
      ),
      MenuEntryModel(
        id: 'learning_map',
        label: 'Mapa de Aprendizagem',
        caption: 'Taxonomias e gaps',
        symbol: MenuEntrySymbol.learningMap,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'multidimension_insights_service.learning_map',
      ),
      MenuEntryModel(
        id: 'certificates',
        label: 'Certificados',
        caption: 'Emitidos e pendentes',
        symbol: MenuEntrySymbol.certificates,
        actionType: MenuEntryActionType.navigation,
        capabilityReference: 'certificates_engine.credentials',
      ),
      MenuEntryModel(
        id: 'focus_mode',
        label: 'Modo Foco',
        caption: 'Bloqueia distrações e alertas',
        symbol: MenuEntrySymbol.focusMode,
        actionType: MenuEntryActionType.toggle,
        capabilityReference: 'learning_engine.focus_mode',
        isToggleOn: false,
      ),
    ];
  }
}
