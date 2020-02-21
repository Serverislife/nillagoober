package main

import (
	"flag"
	"fmt"
	"os"
	"os/signal"
	"syscall"

	"github.com/bwmarrin/discordgo"
)

// Needed for cli action
var (
	Token string
)

func init() {

	flag.StringVar(&Token, "t", "", "Bot token")
	flag.Parse()
}

func main() {

	// Create a new Discord session
	dg, err := discordgo.New("Bot " + Token)
	if err != nil {
		fmt.Println("Could not create discord session:", err)
		return
	}

	// Registers messageCreate actions as callbacks
	dg.AddHandler(messageCreate)

	// Opens a connection to discord and listens
	err = dg.Open()
	if err != nil {
		fmt.Println("Could not open a web socket:", err)
		return
	}

	// Wait here until CTRL-C or other term signal is received.
	fmt.Println("The bot is running.  Press CTRL-C to exit.")
	sc := make(chan os.Signal, 1)
	signal.Notify(sc, syscall.SIGINT, syscall.SIGTERM, os.Interrupt, os.Kill)
	<-sc

	// Cleanly close down the Discord session.
	dg.Close()
}

// This function will be called (due to AddHandler above) every time a new
// message is created on any channel that the autenticated bot has access to.
func messageCreate(s *discordgo.Session, m *discordgo.MessageCreate) {

	// Ignore all messages created by the bot itself
	// This isn't required in this specific example but it's a good practice.
	if m.Author.ID == s.State.User.ID {
		return
	}
	// If the message is "ping" reply with "Pong!"
	if m.Content == "jack" {
		s.ChannelMessageSend(m.ChannelID, ":clowner:")
	}

	// If the message is "pong" reply with "Ping!"
	if m.Content == "@Dumbass bitch Becky" {
		s.ChannelMessageSend(m.ChannelID, "Get the h*ck in here :ohloveme:")
	}
}