from pathlib import Path
import os


def get_required_env(name: str, default: str | None = None) -> str:
    value = os.getenv(name, default)
    if value is None or value == "":
        raise RuntimeError(f"Missing required environment variable: {name}")
    return value


def get_required_secret(name: str) -> str:
    path = Path("/run/secrets") / name
    if not path.exists():
        raise RuntimeError(f"Missing required secret: {name}")
    return path.read_text(encoding="utf-8").strip()
