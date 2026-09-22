from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="QueueGOO Workshop API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Restaurante(BaseModel):
    id: int
    nome: str
    categoria: str
    distancia_km: float
    movimentacao: str


RESTAURANTES = [
    Restaurante(
        id=1,
        nome="Restaurante Central",
        categoria="Brasileira",
        distancia_km=0.8,
        movimentacao="Moderada",
    ),
    Restaurante(
        id=2,
        nome="Pinhais Grill",
        categoria="Churrascaria",
        distancia_km=1.4,
        movimentacao="Alta",
    ),
    Restaurante(
        id=3,
        nome="Sabor Oriental",
        categoria="Japonesa",
        distancia_km=2.1,
        movimentacao="Baixa",
    ),
]


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/restaurants", response_model=list[Restaurante])
def listar_restaurantes():
    # TODO 1: devolver a lista de restaurantes
    return []