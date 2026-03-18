import subprocess
import json
from os import environ

def get_password(url: str, username: str) -> str:
    """Obtiene una credencial específica de Bitwarden."""

    session_token = environ.get("BW_SESSION")

    if not session_token:
        raise RuntimeError("BW_SESSION no está definido. Ejecuta `bw unlock` y exporta el token.")

    result = subprocess.run(
        ["bw", "list", "items", "--session", session_token, "--url", url],
        capture_output=True, text=True
    )

    if result.returncode != 0:
        raise RuntimeError(f"Error al obtener el item '{username}': {result.stderr}")

    data = json.loads(result.stdout)

    # Buscar el campo que quieres
    for item in data:
        if item['username'] == username:
            return item['password']

    raise KeyError(f"Usuario '{username}' no encontrado en la url '{url}'")
