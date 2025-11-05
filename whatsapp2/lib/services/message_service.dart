import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';

class MessageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Buscar mensagens de uma conversa
  Future<List<Message>> getMessages(String conversationId) async {
    try {
      final response = await _supabase
          .from('messages')
          .select()
          .eq('conversation_id', conversationId)
          .eq('is_deleted', false)
          .order('created_at', ascending: true);

      return (response as List)
          .map((json) => Message.fromJson(json))
          .toList();
    } catch (e) {
      print('[v0] Erro ao buscar mensagens: $e');
      rethrow;
    }
  }

  // Enviar mensagem
  Future<Message> sendMessage({
    required String conversationId,
    required String content,
    MessageType type = MessageType.text,
    String? mediaUrl,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('Usuário não autenticado');

      // Buscar nome do usuário
      final userProfile = await _supabase
          .from('profiles')
          .select('name')
          .eq('id', user.id)
          .single();

      final messageData = {
        'conversation_id': conversationId,
        'sender_id': user.id,
        'sender_name': userProfile['name'] ?? 'Usuário',
        'content': content,
        'type': type.toString().split('.').last,
        'media_url': mediaUrl,
      };

      final response = await _supabase
          .from('messages')
          .insert(messageData)
          .select()
          .single();

      // Atualizar última mensagem da conversa
      await _supabase
          .from('conversations')
          .update({
            'last_message': content,
            'last_message_at': DateTime.now().toIso8601String(),
          })
          .eq('id', conversationId);

      return Message.fromJson(response);
    } catch (e) {
      print('[v0] Erro ao enviar mensagem: $e');
      rethrow;
    }
  }

  // Stream de mensagens em tempo real
  Stream<List<Message>> messagesStream(String conversationId) {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .eq('is_deleted', false)
        .order('created_at', ascending: true)
        .map((data) => data.map((json) => Message.fromJson(json)).toList());
  }

  // Deletar mensagem
  Future<void> deleteMessage(String messageId) async {
    try {
      await _supabase
          .from('messages')
          .update({'is_deleted': true})
          .eq('id', messageId);
    } catch (e) {
      print('[v0] Erro ao deletar mensagem: $e');
      rethrow;
    }
  }

  // Editar mensagem
  Future<void> editMessage(String messageId, String newContent) async {
    try {
      await _supabase
          .from('messages')
          .update({
            'content': newContent,
            'edited_at': DateTime.now().toIso8601String(),
          })
          .eq('id', messageId);
    } catch (e) {
      print('[v0] Erro ao editar mensagem: $e');
      rethrow;
    }
  }
}
