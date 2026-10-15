  DROP TABLE IF EXISTS ratings, book_shelves, book_series, series,
                       book_authors, authors, books CASCADE;

CREATE TABLE books (
    book_id          BIGINT PRIMARY KEY,
    work_id          BIGINT,
    title            TEXT NOT NULL,
    description      TEXT,
    language_code    TEXT,
    publisher        TEXT,
    publication_year INTEGER,
    num_pages        INTEGER,
    format           TEXT,
    average_rating   NUMERIC(3, 2),
    ratings_count    INTEGER,
    image_url        TEXT,
    url              TEXT
);

CREATE TABLE authors (
    author_id    BIGINT PRIMARY KEY,
    name         TEXT NOT NULL
);

CREATE TABLE book_authors (
    book_id   BIGINT REFERENCES books(book_id),
    author_id BIGINT REFERENCES authors(author_id),
    role TEXT,
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE series (
    series_id BIGINT PRIMARY KEY,
    title     TEXT NOT NULL
);

CREATE TABLE book_series (
    book_id   BIGINT REFERENCES books(book_id),
    series_id BIGINT REFERENCES series(series_id),
    PRIMARY KEY (book_id, series_id)
);

CREATE TABLE book_shelves (
    book_id  BIGINT REFERENCES books(book_id),
    shelf_name TEXT,
    shelf_count INTEGER,
    PRIMARY KEY (book_id, shelf_name)
);

CREATE TABLE ratings (
    user_id TEXT,
    book_id BIGINT REFERENCES books(book_id),
    rating  SMALLINT CHECK (rating BETWEEN 1 AND 5),
    is_read BOOLEAN,
    date_added TIMESTAMPTZ,
    PRIMARY KEY (user_id, book_id)
);

CREATE INDEX idx_ratings_book ON ratings (book_id);