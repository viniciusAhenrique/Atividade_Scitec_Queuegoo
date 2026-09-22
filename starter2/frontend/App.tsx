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

  const [restauranteSelecionado, setRestauranteSelecionado] = useState<Restaurante | null>(null);
  const [detalheLoading, setDetalheLoading] = useState(false);
  const [detalheErro, setDetalheErro] = useState<string | null>(null);

  async function carregarDetalhes(id: number) {
    setDetalheLoading(true);
    setDetalheErro(null);
    setRestauranteSelecionado(null);

    try {
      const response = await fetch(`${API_URL}/restaurant/${id}`);

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const data: Restaurante = await response.json();
      setRestauranteSelecionado(data);
    } catch (e) {
      console.error(e);
      setDetalheErro("Não foi possível carregar os detalhes.");
    } finally {
      setDetalheLoading(false);
    }
  }

  async function carregarRestaurantes() {
    setLoading(true);
    setErro(null);

    try {
      const response = await fetch(`${API_URL}/restaurants`);

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      const data: Restaurante[] = await response.json();

      setRestaurantes(data);
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
      <Text style={styles.subtitulo}>Atividade Prática 2</Text>

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
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={`Ver detalhes de ${item.nome}`}
                style={[styles.botao, styles.detalhesBotao, detalheLoading && styles.desabilitado]}
                disabled={detalheLoading}
                onPress={() => carregarDetalhes(item.id)}
              >
                <Text style={styles.botaoTexto}>Ver detalhes</Text>
              </Pressable>
            </View>
          )}
          ListHeaderComponent={
            <View>
              {detalheLoading && <ActivityIndicator size="large" accessibilityLabel="Carregando detalhes" />}
              {detalheErro && (
                <View style={styles.card}>
                  <Text style={styles.erro}>{detalheErro}</Text>
                </View>
              )}
              {restauranteSelecionado && (
                <View style={styles.card}>
                  <Text style={styles.subtitulo}>DETALHES DO RESTAURANTE</Text>
                  <Text style={styles.nome}>{restauranteSelecionado.nome}</Text>
                  <Text>Categoria: {restauranteSelecionado.categoria}</Text>
                  <Text>Distância: {restauranteSelecionado.distancia_km.toFixed(1)} km</Text>
                  <Text>Movimentação: {restauranteSelecionado.movimentacao}</Text>
                  <Pressable
                    accessibilityRole="button"
                    style={[styles.botao, styles.detalhesBotao]}
                    onPress={() => setRestauranteSelecionado(null)}
                  >
                    <Text style={styles.botaoTexto}>Fechar</Text>
                  </Pressable>
                </View>
              )}
            </View>
          }
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

  detalhesBotao: {
    marginTop: 12,
  },

  desabilitado: {
    opacity: 0.6,
  },

  botaoTexto: {
    color: "white",
    fontWeight: "700",
  },
});