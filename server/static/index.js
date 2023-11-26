
const Authorization = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDMxNjI3MDAsImlhdCI6MTcwMDU3MDcwMCwiaWQiOiIwMmRhZTBmMC00ZDQ4LTRjZDYtOWI5OC05M2U5N2Q5NDZjNGIiLCJpc3MiOiJhdWRpb19zdHJlYW1fc2VydmVyIn0.NKLqZsKUZLPYQRlSCvtGJ35Zx8qI8upVvMC3Ojd3PhuwMzD7qBNd-VkR_0g6z5ZYyFSidUne57_iX5eWoYxz4Q"

const pc = new RTCPeerConnection({
  iceServers: [{
    urls: [
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
    ]
  }]
})
const log = msg => {
  document.getElementById('div').innerHTML += msg + '<br>'
}


var sendChannel = pc.createDataChannel("messages")
sendChannel.onclose = () => console.log('sendChannel has closed')
sendChannel.onopen = () => console.log('sendChannel has opened')
sendChannel.onmessage = e => log(`Message from DataChannel '${sendChannel.label}' payload '${e.data}'`)


pc.ontrack = function (event) {
  log("call ontrack")

  const el = document.createElement(event.track.kind)
  el.srcObject = event.streams[0]
  el.autoplay = true
  el.controls = true

  document.getElementById('remoteVideos').appendChild(el)
}

pc.oniceconnectionstatechange = e => log(pc.iceConnectionState)
pc.onicecandidate = event => {
  if (event.candidate === null) {
    log("get answer")
    document.getElementById('localSessionDescription').value = JSON.stringify(pc.localDescription)

    let setServerSDP = (roomid) =>{
      fetch("/api", {
        headers: [["Authorization", Authorization]],
        method: 'POST',
        redirect: 'follow',
        body: JSON.stringify({
          query: "mutation sdp($roomId: String!, $type: String!, $sdp: String!) {\n  InitConnection(RoomId: $roomId, SDP: {Type: $type, Sdp: $sdp}) {\n    Sdp\n    Type\n  }\n}\n",
          variables: {
            roomId: roomid,
            type: pc.localDescription.type,
            sdp: pc.localDescription.sdp
          }
        }),
      })
      .then(response => response.json())
      .then(result => {
        document.getElementById('remoteSessionDescription').value = JSON.stringify({
          type: result["data"]["InitConnection"]["Type"],
          sdp: result["data"]["InitConnection"]["Sdp"],
        })
        window.startSession()
      })
    }


      fetch("/api", {
        headers: [["Authorization", Authorization]],
        method: 'POST',
        redirect: 'follow',
        body: JSON.stringify({
          query: 'query ListRooms{ListRooms{Id}}',
        }),
      })
      .then(response => response.json())
      .then(result => {
        let firstRoom = result["data"]["ListRooms"][0]["Id"]
        setServerSDP(firstRoom)
      })
      
  }
}


pc.addTransceiver('video', {
  direction: 'sendrecv'
})
pc.addTransceiver('audio', {
  direction: 'sendrecv'
})

pc.createOffer().then(d => pc.setLocalDescription(d)).catch(log)

window.startSession = () => {
  const sd = document.getElementById('remoteSessionDescription').value
  if (sd === '') {
    return alert('Session Description must not be empty')
  }

  try {
    pc.setRemoteDescription(JSON.parse(sd))
  } catch (e) {
    alert(e)
  }
}
