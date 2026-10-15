import gzip
import json
from pathlib import Path

DATA = Path("data/raw")
FILES = [
    "goodreads_books_comics_graphic.json.gz",
    "goodreads_interactions_comics_graphic.json.gz",
]

def short(value):
    """Shorten long values so every field fits on screen."""
    if isinstance(value, list):
        return f"list of {len(value)}, first 3: {value[:3]}"
    if isinstance(value, str) and len(value) > 80:
        return value[:80] + "..."
    return value

for name in FILES:
    print("=" * 60)
    print(name)
    print("=" * 60)
    with gzip.open(DATA / name, "rt", encoding="utf-8") as f:
        for i, line in enumerate(f):
            record = json.loads(line)
            for key, value in record.items():
                print(f"{key:28} {short(value)}")
            print("-" * 60)
            if i == 2:  # show 3 records per file
                break