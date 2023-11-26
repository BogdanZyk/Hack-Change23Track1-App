-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS new_users (
	id TEXT,
    login TEXT,
	password_hash TEXT,
    name TEXT,
    avatar TEXT,

    inserted_at timestamp DEFAULT (datetime('now')),
	updated_at TIMESTAMP DEFAULT (datetime('now'))
);

INSERT INTO new_users
SELECT id, login, password_hash, '', '', inserted_at, updated_at FROM users;

DROP TABLE users;

ALTER TABLE new_users RENAME TO users ;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE users;
-- +goose StatementEnd
