package main

import (
	"github.com/mattermost/mattermost-server/plugin"
)

// Plugin corresponds with how we expose the Mattermost Plugin API to
// the Mattermost application itself
type Plugin struct {
	plugin.MattermostPlugin
}

func main() {
	plugin.ClientMain(&Plugin{})
}
