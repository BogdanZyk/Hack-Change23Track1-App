package migrations

import (
	"database/sql"
	"os"

	"github.com/pressly/goose/v3"
)

func Migrate(db *sql.DB) error {
	goose.SetLogger(goose.NopLogger())

	migrations := os.DirFS("./migrations/sql")

	goose.SetBaseFS(migrations)

	if err := goose.SetDialect("sqlite3"); err != nil {
		return err
	}
	if err := goose.Up(db, "."); err != nil {
		return err
	}

	return nil
}
