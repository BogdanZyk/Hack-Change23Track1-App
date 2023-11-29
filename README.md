# Soundwave

An application for group
online listening to audio content

### Mobile application written for iOS with MVVM architecture in Swift language 

#### Frameworks and libraries used:

Client side:
- SwiftUI - interface layout
- Combine - asynchrony and reactivity
- Apollo GraphQL - API query processing
- NukeUI - image caching 
- WebRTC - data feeds and audio streaming

Server side:
- Go
- SQlite
- Apollo GraphQL
- WebRTC

## Functionality:
- User registration (mail/password)
- Room list
- Create public and private rooms
- Connecting to a room by code
- Room management by administrator
- Room playlist creation
- Synchronization of audio between all participants maximum delays not more than 0.2c
- Actions with audio rewind, switching 
- Chat between participants
- Animated room likes
- Reactions to messages
- Stickers in message
- Light dark theme

  ## 📹 Video
[![Preview](http://img.youtube.com/vi/_jVpYgHdr4Q/0.jpg)](https://www.youtube.com/watch?v=_jVpYgHdr4Q)


## Start server
- go v.1.21.1
- brew install golang
- сd server
- go build -o audio-stream && ./audio-stream


## Schematic of client server architecture
 <div align="center">
 <img src="screens/schema.jpeg" height="450" alt="Screenshot"/>
 </div>

## Screenshots 📷
  <div align="center">
 <img src="screens/1.jpeg" height="450" alt="Screenshot"/>
  <img src="screens/2.jpeg" height="450" alt="Screenshot"/>
    <img src="screens/3.jpeg" height="450" alt="Screenshot"/>
    <img src="screens/4.jpeg" height="450" alt="Screenshot"/>
    <img src="screens/5.jpeg" height="450" alt="Screenshot"/>
     <img src="screens/6.png" height="450" alt="Screenshot"/>
  </div>




