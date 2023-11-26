package webrtc

import (
	"context"
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/pion/webrtc/v4"
	"gitlab.com/tatsiyev/audio-stream/models"
)

type StreamClient struct {
	key         string
	User        *models.User
	Connection  *webrtc.PeerConnection
	DataChannel *webrtc.DataChannel
	room        *StreamRoom
}

func NewConnection() (*webrtc.PeerConnection, error) {

	peerConnection, err := webrtc.NewPeerConnection(webrtc.Configuration{
		ICEServers: []webrtc.ICEServer{
			{
				URLs: []string{
					"stun:freestun.net:5350",
					"stun:stun.freestun.net:3479",
					"stun:stun.l.google.com:19302",
					"stun:stun1.l.google.com:19302",
					"stun:stun2.l.google.com:19302",
					"stun:stun3.l.google.com:19302",
					"stun:stun4.l.google.com:19302",
					"stun:stun1.voiceeclipse.net:3478",
					"stun:stun.zoiper.com:3478",
					"stun:stun.netappel.com:3478",
					"stun:stun.netappel.fr:3478",
				},
			},
		},
	})

	return peerConnection, err
}

func (c *StreamClient) ClientWorker(clientSdp *models.SDP, serverSDP chan *models.SDP) error {

	defer c.room.SendStructAllClients(models.TextMessage{
		Id:        uuid.NewString(),
		From:      c.User,
		Type:      models.TextMessageType_Leaving,
		Reactions: []*models.ReactionMessage{},
	})

	defer delete(c.room.clients, c.key)
	defer delete(c.room.Room.Users, c.key)

	exit := make(chan interface{})

	conn, err := NewConnection()
	if err != nil {
		serverSDP <- nil
		return err
	}
	c.Connection = conn

	dc, err := conn.CreateDataChannel("messages", nil)
	if err != nil {
		serverSDP <- nil
		return err
	}
	c.DataChannel = dc
	dc.OnOpen(func() { fmt.Println("open") })
	dc.OnClose(func() { fmt.Println("close") })
	dc.OnMessage(func(msg webrtc.DataChannelMessage) { c.room.DataChannelHandler(dc, msg, c.User) })

	defer func() {
		if cErr := c.Connection.Close(); cErr != nil {
			fmt.Printf("cannot close peerConnection: %v\n", cErr)
		}
	}()

	iceConnectedCtx, iceConnectedCtxCancel := context.WithCancel(context.Background())
	defer iceConnectedCtxCancel()

	go func() {
		rtpSender, trackErr := c.Connection.AddTrack(c.room.track)
		if trackErr != nil {
			exit <- nil
			return
		}

		go func() {
			rtcpBuf := make([]byte, 1500)
			for {
				if n, a, rtcpErr := rtpSender.Read(rtcpBuf); rtcpErr != nil {
					fmt.Printf("read from sender: %d, %#v\n", n, a)
					exit <- nil
					return
				}
			}
		}()
	}()

	c.Connection.OnICEConnectionStateChange(func(connectionState webrtc.ICEConnectionState) {
		fmt.Printf("Connection State has changed %s \n", connectionState.String())
		if connectionState == webrtc.ICEConnectionStateConnected {
			iceConnectedCtxCancel()
		}
	})

	c.Connection.OnConnectionStateChange(func(s webrtc.PeerConnectionState) {
		fmt.Printf("Peer Connection State has changed: %s\n", s.String())

		if s == webrtc.PeerConnectionStateFailed {
			fmt.Println("Peer Connection has gone to failed exiting")
			exit <- nil
			return
		}
		if s == webrtc.PeerConnectionStateClosed {
			fmt.Println("Peer Connection has gone to closed exiting")
			exit <- nil
			return
		}
		if s == webrtc.PeerConnectionStateDisconnected {
			fmt.Println("Peer Connection has gone to disconecting")
			exit <- nil
			return
		}
	})

	// Set the remote SessionDescription
	cl := webrtc.SessionDescription{Type: webrtc.NewSDPType(clientSdp.Type), SDP: clientSdp.SDP}
	if err = c.Connection.SetRemoteDescription(cl); err != nil {
		serverSDP <- nil
		return err
	}

	// Create answer
	answer, err := c.Connection.CreateAnswer(nil)
	if err != nil {
		serverSDP <- nil
		return err
	}

	gatherComplete := webrtc.GatheringCompletePromise(c.Connection)

	if err = c.Connection.SetLocalDescription(answer); err != nil {
		serverSDP <- nil
		return err
	}

	<-gatherComplete

	localSDP := *c.Connection.LocalDescription()
	serverSDP <- &models.SDP{Type: localSDP.Type.String(), SDP: localSDP.SDP}

	<-iceConnectedCtx.Done()

	time.Sleep(500 * time.Millisecond)
	c.room.SendStructAllClients(models.TextMessage{
		Id:        uuid.NewString(),
		From:      c.User,
		Type:      models.TextMessageType_Joined,
		Reactions: []*models.ReactionMessage{},
	})

	m := <-exit
	fmt.Printf("client exit %#v\n", m)
	return nil

}
