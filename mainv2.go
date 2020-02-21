package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"
)

type AutoGenerated struct {
	Data []struct {
		ID           string    `json:"id"`
		UserID       string    `json:"user_id"`
		UserName     string    `json:"user_name"`
		GameID       string    `json:"game_id"`
		Type         string    `json:"type"`
		Title        string    `json:"title"`
		ViewerCount  int       `json:"viewer_count"`
		StartedAt    time.Time `json:"started_at"`
		Language     string    `json:"language"`
		ThumbnailURL string    `json:"thumbnail_url"`
		TagIds      []string   `json:"tag_ids"`
	} `json:"data"`
	Pagination struct {
		Cursor string `json:"cursor"`
	} `json:"pagination"`
}

func api_call() {
	url := "https://api.twitch.tv/helix/streams?user_id=51496027"
	var bearer = "<my_token>"

	req, err := http.NewRequest("GET", url, nil)
	req.Header.Add("Client-ID", bearer)

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		log.Println("Error in response.\n[ERRO] -", err)
	}

	var response AutoGenerated
	err = json.NewDecoder(resp.Body).Decode(&response)
	if err != nil {
		fmt.Printf("Error: failed decoding body: %v", err)
	}

	fmt.Println("viewer count = ", response.Data[0].ViewerCount)
}