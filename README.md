# README

### Available API endpoints

- `GET /api/v1/stocks` - returns stocks with bearer information, limited to 100 entities
- `POST /api/v1/stocks` - creates a stock with a bearer (see API schema for params structure)
- `PATCH /api/v1/stocks/:id` - update a stock, if bearer name is provided creates / sets a new bearer
- `DELETE /api/v1/stocks/:id` - marks a stock as deleted


### High-level architecture
```


                                                         +                                       +
                                                         |                                       |
                                                         |                                       |
                                                         |                                       |
                                                         |                                       |
                                                         |                                       |
Request data              +--------------------+         |           +---------------------+     |          +-----------------------+              Response data
                          |                    |         |           |                     |     |          |                       |
                          | Schema validation  |         |           | Business actions    |     |          | Representation layer  |
       +------------------> layer              +-------------------->+ layer               +--------------->+                       +---------------->
                          |                    |         |           |                     |     |          |                       |
                          |                    |         |           |                     |     |          |                       |
                          +--------------------+         |           +---------------------+     |          +-----------------------+
                                                         |                                       |
                                                         |                                       |
                                                         |                                       |
                                                         +                                       +


```

### Technical notes

- Rails app generated in API mode to skip redundant configs and files
- API 100% covered by integration specs
- Custom JSON schema matcher has been implemented to thoroughly verify the API response structure
- For complicated actions (e.g Stocks::Create/Update), unit tests have been created, all external dependencies are mocked

#### To improve

- Pagination is missing, index just limits for 100 records
- Authorization by token is missing
- Migrate to RDBMS from SQlite
