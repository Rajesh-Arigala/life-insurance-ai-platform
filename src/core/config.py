import os
from copy import deepcopy
from pathlib import Path

import yaml
from dotenv import load_dotenv


PROJECT_ROOT = Path(__file__).resolve().parents[2]


def _load_yaml(path: Path) -> dict:
    """Load a YAML file and return a dictionary."""
    with path.open("r", encoding="utf-8") as file:
        return yaml.safe_load(file) or {}


def _deep_merge(base: dict, override: dict) -> dict:
    """Recursively merge override configuration into base configuration."""
    result = deepcopy(base)

    for key, value in override.items():
        if (
            key in result
            and isinstance(result[key], dict)
            and isinstance(value, dict)
        ):
            result[key] = _deep_merge(result[key], value)
        else:
            result[key] = value

    return result


def load_config(environment: str = "dev") -> dict:
    """
    Load project configuration in this order:

    1. .env
    2. configs/base.yaml
    3. configs/<environment>.yaml

    Environment-specific settings override base settings.
    """

    # Load secrets/local environment variables
    load_dotenv(PROJECT_ROOT / ".env")

    # Load YAML configuration
    base_config = _load_yaml(
        PROJECT_ROOT / "configs" / "base.yaml"
    )

    env_config = _load_yaml(
        PROJECT_ROOT / "configs" / f"{environment}.yaml"
    )

    # Merge base + environment configuration
    config = _deep_merge(base_config, env_config)

    # Resolve database environment variables
    db_config = config["database"]

    config["database"]["host"] = os.getenv(
        db_config["host_env"]
    )

    config["database"]["port"] = int(
        os.getenv(db_config["port_env"], "3306")
    )

    config["database"]["user"] = os.getenv(
        db_config["user_env"]
    )

    config["database"]["password"] = os.getenv(
        db_config["password_env"]
    )

    config["database"]["policy_db"] = os.getenv(
        db_config["policy_db_env"]
    )

    config["database"]["billing_db"] = os.getenv(
        db_config["billing_db_env"]
    )

    # Validate required database configuration
    required = [
        "host",
        "user",
        "password",
        "policy_db",
        "billing_db",
    ]

    missing = [
        key
        for key in required
        if not config["database"].get(key)
    ]

    if missing:
        raise ValueError(
            f"Missing required database configuration: {missing}"
        )

    return config