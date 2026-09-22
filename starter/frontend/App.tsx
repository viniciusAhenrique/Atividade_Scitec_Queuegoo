import React, { useEffect, useState } from "react";

import {
  ActivityIndicator,
  FlatList,
  Pressable,
  SafeAreaView,
  StyleSheet,
  Text,
  View,
} from "react-native";

type Restaurante = {
  id: number;
  nome: string;
  categoria: string;
  distancia_km: number;
  movimentacao: string;
};

const API_URL =
  process.env.EXPO_PUBLIC_API_URL ?? "http://127.0.0.1:8000";

export default function App() {
  const [restaurantes, setRestaurantes] = useState<Restaurante[]>([]);
  const [loading, setLoading] = useState(true);
  const [erro, setErro] = useState<string | null>(null);

  async function carregarRestaurantes() {
    setLoading(true);
    setErro(null);

    try {
      // TODO 2: chamar GET /restaurants usando fetch.

      // TODO 3: verificar response.ok, converter a resposta usando
      // response.json() e atualizar setRestaurantes(data).
      setRestaurantes([]);
    } catch (e) {
      console.error(e);
      setErro("Não foi possível carregar os restaurantes.");
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    carregarRestaurantes();
  }, []);

  return (
    <SafeAreaView style={styles.container}>
      <Text style={styles.titulo}>QueueGOO — Restaurantes</Text>
      <Text style={styles.subtitulo}>Atividade Prática 1</Text>

      {loading && <ActivityIndicator size="large" />}

      {!loading && erro && (
        <View style={styles.estado}>
          <Text style={styles.erro}>{erro}</Text>

          <Pressable
            style={styles.botao}
            onPress={carregarRestaurantes}
          >
            <Text style={styles.botaoTexto}>
              Tentar novamente
            </Text>
          </Pressable>
        </View>
      )}

      {!loading && !erro && (
        <FlatList
          data={restaurantes}
          keyExtractor={(item) => String(item.id)}
          renderItem={({ item }) => (
            <View style={styles.card}>
              <Text style={styles.nome}>{item.nome}</Text>
              <Text>{item.categoria}</Text>
              <Text>{item.distancia_km.toFixed(1)} km</Text>
              <Text>
                Movimentação: {item.movimentacao}
              </Text>
            </View>
          )}
          ListEmptyComponent={
            <Text>Nenhum restaurante recebido da API.</Text>
          }
        />
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 24,
    backgroundColor: "#f5f7f5",
  },

  titulo: {
    fontSize: 24,
    fontWeight: "700",
    marginBottom: 20,
  },

  subtitulo: {
    marginBottom: 20,
    fontSize: 16,
  },

  card: {
    backgroundColor: "white",
    padding: 16,
    marginBottom: 12,
    borderRadius: 10,
  },

  nome: {
    fontSize: 18,
    fontWeight: "700",
    marginBottom: 4,
  },

  estado: {
    gap: 12,
  },

  erro: {
    color: "#b42318",
  },

  botao: {
    alignSelf: "flex-start",
    backgroundColor: "#2e7d32",
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 8,
  },

  botaoTexto: {
    color: "white",
    fontWeight: "700",
  },
});