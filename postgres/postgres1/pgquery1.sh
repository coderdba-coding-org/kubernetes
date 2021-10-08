docker run --env PGPASSWORD=password --rm tmaier/postgresql-client:latest  -h 192.168.56.11 -p 32694 -U postgres -d test1 -c "select * from x1;"
