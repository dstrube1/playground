package main

//to run:
//go run main.go

import (
	"context"
	"fmt"
	"io/ioutil"
	"log"
	"os"

	"github.com/machinebox/graphql"
)

type application struct {
	conn *graphql.Client
}

func readQuery(filename string) (string, error) {
	query, err := ioutil.ReadFile(filename)
	if err != nil {
		return "", err
	}
	return string(query), nil
}

func (app *application) makeRequest(query string) (map[string]interface{}, error) {
	req := graphql.NewRequest(query)
	openstatesApikey := os.Getenv("OPENSTATES_APIKEY")
	req.Header.Set("X-API-KEY", openstatesApikey)
	ctx := context.Background()

	var responseData map[string]interface{}
	err := app.conn.Run(ctx, req, &responseData)
	if err != nil {
		log.Println(err)
		return nil, nil
	}

	return responseData, nil
}

func main() {
	client := graphql.NewClient("https://openstates.org/graphql")
	app := &application{conn: client}

	query, err := readQuery("graphql.query")
	if err != nil {
		log.Fatal(err)
	}

	resp, err := app.makeRequest(query)
	if err != nil {
		log.Fatal(err)
	}

	for k, v := range resp {
		fmt.Printf("%v: \n", k)
		r := v.(map[string]interface{})
		for i, t := range r {
			fmt.Printf("\t%v: %v\n", i, t)
		}
	}
}
