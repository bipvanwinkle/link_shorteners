defmodule LinkMaker.Repo.Migrations.PopulateSource do
  use Ecto.Migration

  def up do
    execute("""
    CREATE OR REPLACE FUNCTION generate_key(len int)
    RETURNS text AS $$
    DECLARE
        result text := '';
        chars text := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        i int;
    BEGIN
        -- Generate a random key and loop until we find a unique one
        LOOP
            -- Reset the result for each attempt
            result := '';
            
            -- Generate the random string
            FOR i IN 1..len LOOP
                result := result || substr(chars, floor(random() * length(chars) + 1)::int, 1);
            END LOOP;

            -- Check if the key is already in the database
            IF NOT EXISTS (SELECT 1 FROM links WHERE key = result) THEN
                -- If it's unique, return the result
                RETURN result;
            END IF;

            -- If it exists, loop and generate a new one
        END LOOP;
    END;
    $$ LANGUAGE plpgsql;
    """)
  end

  def down do
    execute("""
    CREATE OR REPLACE FUNCTION generate_key(len int)
    RETURNS text AS $$
    DECLARE
        result text := '';
        chars text := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        i int;
    BEGIN
        FOR i IN 1..len LOOP
            result := result || substr(chars, floor(random() * length(chars) + 1)::int, 1);
        END LOOP;
        RETURN result;
    END;
    $$ LANGUAGE plpgsql;
    """)
  end
end
