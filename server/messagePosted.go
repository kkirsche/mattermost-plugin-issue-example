package main

import (
	"github.com/mattermost/mattermost-server/model"
	"github.com/mattermost/mattermost-server/plugin"
)

// MessageHasBeenPosted is invoked after the message has been committed to the
// database. If you need to modify or reject the post, see MessageWillBePosted
// Note that this method will be called for posts created by plugins, including
// the plugin that created the post.
func (p *Plugin) MessageHasBeenPosted(c *plugin.Context, post *model.Post) {
	// Ignore posts made by mattermost plugins
	if sentByPlugin, _ := post.Props["sent_by_plugin"].(bool); sentByPlugin {
		return
	}

	p.API.CreatePost(&model.Post{
		UserId:    post.UserId,
		ChannelId: post.ChannelId,
		Message:   "Example plugin which does nothing",
		Props: map[string]interface{}{
			"sent_by_plugin": true,
		},
	})
}
