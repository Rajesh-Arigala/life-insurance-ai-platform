from src.core.config import _deep_merge


def test_deep_merge_preserves_base_and_overrides_nested_values():
    base = {
        "database": {
            "driver": "mysql+pymysql",
            "echo_sql": True,
        },
        "logging": {
            "level": "INFO",
        },
    }

    override = {
        "database": {
            "echo_sql": False,
        }
    }

    merged = _deep_merge(base, override)

    # Override should win
    assert merged["database"]["echo_sql"] is False

    # Existing base values should remain
    assert merged["database"]["driver"] == "mysql+pymysql"
    assert merged["logging"]["level"] == "INFO"

    # Original base config should not be mutated
    assert base["database"]["echo_sql"] is True