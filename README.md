# Setup and run server

```
bin/setup
bin/server
```

# API endpoints

## Create Stock

```bash
curl -X POST http://localhost:3000/v1/stocks -H 'Content-Type: application/json' \
  -d '{"stock":{"name":"Stock Name","bearer_name":"Bearer Name"}}'
```

## Update stock

```bash
curl -X PUT http://localhost:3000/v1/stocks/1 -H 'Content-Type: application/json' \
  -d '{"stock":{"name":"Updated Name"}}'
```

### Link stock to another bearer

```bash
curl -X PUT http://localhost:3000/v1/stocks/1 -H 'Content-Type: application/json' \
  -d '{"stock":{"name":"Updated Name","bearer_name":"Another Bearer"}}'
```

### Soft delete stock

```bash
curl -X DELETE http://localhost:3000/v1/stocks/1
```

### List all stocks


```bash
curl http://localhost:3000/v1/stocks -H 'Content-Type: application/json'
```

# Specs

```
bin/rspec spec/
```
