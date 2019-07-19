module github.com/louisrdev/intentionally-vulnerable-golang-project

require (
	github.com/BurntSushi/toml v0.3.1
	github.com/dgraph-io/badger v1.5.5-0.20181004181505-439fd464b155
	github.com/etcd-io/etcd v3.3.13+incompatible
	github.com/logrusorgru/aurora v0.0.0-20181002194514-a7b3b318ed4e
	github.com/louisrdev/intentionally-vulnerable-golang-project/sub1 v1.0.0
	github.com/louisrdev/intentionally-vulnerable-golang-project/sub2 v1.0.0
	github.com/louisrdev/intentionally-vulnerable-golang-project/sub3 v1.0.0
	github.com/shopspring/decimal v0.0.0-20180709203117-cd690d0c9e24
	github.com/stretchr/testify v1.3.0
)

replace github.com/louisrdev/intentionally-vulnerable-golang-project/sub1 => ./sub1

replace github.com/louisrdev/intentionally-vulnerable-golang-project/sub2 => ./sub2

replace github.com/louisrdev/intentionally-vulnerable-golang-project/sub3 => ./sub3
