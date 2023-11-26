-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS audio (
	id TEXT,
    name TEXT,
	path TEXT,

    inserted_at timestamp DEFAULT (datetime('now')),
	updated_at TIMESTAMP DEFAULT (datetime('now'))
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE audio;
-- +goose StatementEnd
