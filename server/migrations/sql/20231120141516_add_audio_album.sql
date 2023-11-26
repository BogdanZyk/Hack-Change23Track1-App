-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS new_audio (
	id TEXT,
    name TEXT,
	path TEXT,
	cover TEXT,

    inserted_at timestamp DEFAULT (datetime('now')),
	updated_at TIMESTAMP DEFAULT (datetime('now'))
);

INSERT INTO new_audio
SELECT id, name, path, '', inserted_at, updated_at FROM audio;

DROP TABLE audio;

ALTER TABLE new_audio RENAME TO audio ;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE audio;
-- +goose StatementEnd
