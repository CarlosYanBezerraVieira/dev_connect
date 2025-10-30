import 'package:intl/intl.dart';

class DateFormatter {
  /// Formata uma data em formato relativo amigável
  /// 
  /// Exemplos:
  /// - "agora" - menos de 1 minuto
  /// - "há 15m" - menos de 1 hora
  /// - "há 3h" - menos de 1 dia
  /// - "há 2d" - menos de 7 dias
  /// - "há 2s" - menos de 30 dias
  /// - "30/10/2025" - mais antigo que 30 dias
  static String formatRelativeDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    // Menos de um minuto
    if (difference.inSeconds < 60) {
      return 'agora';
    }

    // Menos de uma hora
    if (difference.inMinutes < 60) {
      return 'há ${difference.inMinutes}m';
    }

    // Menos de um dia
    if (difference.inHours < 24) {
      return 'há ${difference.inHours}h';
    }

    // Menos de 7 dias (mesma semana)
    if (difference.inDays < 7) {
      return 'há ${difference.inDays}d';
    }

    // Mesma semana mas diferente de 7 dias
    if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'há ${weeks}s';
    }

    // Data completa se for mais antigo
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Formata data em formato longo
  static String formatLongDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd MMMM yyyy, HH:mm', 'pt_BR').format(date);
  }

  /// Formata data em formato curto
  static String formatShortDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
