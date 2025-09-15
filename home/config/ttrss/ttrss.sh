#! /bin/sh

case "$1" in
    dump)    docker exec -i ttrss_db pg_dump --no-acl --no-owner --user ttrss --dbname ttrss > ttrss.sql ;;
    restore) docker exec -i ttrss_db psql                        --user ttrss --dbname ttrss < ttrss.sql ;;
    *)       echo "Usage: $0 <dump|restore>" 1>&2 && exit 1 ;;
esac
