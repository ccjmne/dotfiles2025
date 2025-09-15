#! /bin/sh

case "$1" in
    dump)    docker exec -i ttrss_db pg_dump --user ttrss --dbname ttrss --clean --if-exists --no-acl --no-owner > ttrss.sql ;;
    restore) docker exec -i ttrss_db psql    --user ttrss --dbname ttrss                                         < ttrss.sql ;;
    *)       echo "Usage: $0 <dump|restore>" 1>&2 && exit 1 ;;
esac
