-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS users (
	id TEXT,
    login TEXT,
	password_hash TEXT,

    inserted_at timestamp DEFAULT (datetime('now')),
	updated_at TIMESTAMP DEFAULT (datetime('now'))
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE users;
-- +goose StatementEnd
