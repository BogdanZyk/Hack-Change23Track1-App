//
//  WebrtcClient2.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 29.11.2023.
//

import Foundation
import WebRTC

protocol WebRTCClientDelegate: AnyObject {
    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate)
    func webRTCClient(_ client: WebRTCClient, didAdd stream: RTCMediaStream)
    func webRTCClient(_ client: WebRTCClient, didStartReceivingOnTrack track: RTCVideoTrack)
    func webRTCClient(_ client: WebRTCClient, didChangeConnectionState state: RTCIceConnectionState)
    func webRTCClient(_ client: WebRTCClient, didReceiveData data: Data)
}

class WebRTCClient: NSObject {

    private static let factory: RTCPeerConnectionFactory = {
        RTCInitializeSSL()
        let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        videoEncoderFactory.preferredCodec = RTCVideoCodecInfo(name: kRTCVideoCodecVp8Name)
        let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()
    private let mediaConstraints = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    private let optionalConstraints = ["DtlsSrtpKeyAgreement": "true"]
    private let rtcAudioSession = RTCAudioSession.sharedInstance()

    private var candidateQueue = [RTCIceCandidate]()

    private var peerConnection: RTCPeerConnection?
    private var localVideoSource: RTCVideoSource?
    var localVideoTrack: RTCVideoTrack?
    var videoCapturer: RTCCameraVideoCapturer?
    var remoteVideoTrack: RTCVideoTrack?


    var localAudioTrack : RTCAudioTrack?
    private var remoteDataChannel: RTCDataChannel?
    private var localDataChannel: RTCDataChannel?

    weak var delegate: WebRTCClientDelegate?

    private var hasReceivedSdp = false

    override init() {
        super.init()
        setup()
    }

    var VideoIsEnable:Bool{
        get{
            if(localVideoTrack == nil){
                return true
            }

            return localVideoTrack!.isEnabled
        }
        set{
            localVideoTrack?.isEnabled = newValue;
        }
    }

    var AudioIsEnable:Bool{
        get{
            if(localAudioTrack == nil){
                return true
            }

            return localAudioTrack!.isEnabled
        }
        set{
            localAudioTrack?.isEnabled = newValue;
        }
    }

    func setup() {
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: optionalConstraints)
        let config = generateRTCConfig()

        peerConnection = WebRTCClient.factory.peerConnection(with: config, constraints: constraints, delegate: self)

        createMediaSenders()
        createDataSenders()
    }

    func disconnect() {
        hasReceivedSdp = false
        peerConnection?.close()
        peerConnection = nil
        localVideoSource = nil
        localVideoTrack = nil
        videoCapturer = nil
        remoteVideoTrack = nil
    }

    func sendData(_ data: Data) {
        let buffer = RTCDataBuffer(data: data, isBinary: true)
        self.remoteDataChannel?.sendData(buffer)
    }
}

// MARK: - Generate and set description logic
extension WebRTCClient {

    func offer() async throws -> RTCSessionDescription {

        guard let peerConnection else {
            throw AppError.custom(errorDescription: "No init peerConnection")
        }

        let constrains = RTCMediaConstraints(mandatoryConstraints: self.mediaConstraints,
                                             optionalConstraints: nil)

        let sdp = try await peerConnection.offer(for: constrains)
        try await setLocalDescription(sdp)

        return sdp
    }

    func answer() async throws -> RTCSessionDescription {

        guard let peerConnection else {
            throw AppError.custom(errorDescription: "No init peerConnection")
        }

        let constrains = RTCMediaConstraints(mandatoryConstraints: self.mediaConstraints,
                                             optionalConstraints: nil)
        let sdp = try await peerConnection.answer(for: constrains)
        try await setLocalDescription(sdp)
        return sdp
    }

    func set(remoteSdp: RTCSessionDescription) async throws {
        try await peerConnection?.setRemoteDescription(remoteSdp)
       // await setCandidatesQueue()
    }

    func set(remoteCandidate: RTCIceCandidate) async throws {
        guard let peerConnection else {
            throw AppError.custom(errorDescription: "No init peerConnection")
        }
        try await peerConnection.add(remoteCandidate)
    }

    private func setLocalDescription(_ sdp: RTCSessionDescription) async throws {
        guard let peerConnection else {
            throw AppError.custom(errorDescription: "No init peerConnection")
        }
        try await peerConnection.setLocalDescription(sdp)
    }

}

// MARK: Preparing parts.
extension WebRTCClient {
    private func generateRTCConfig() -> RTCConfiguration {
        let config = RTCConfiguration()
//        let pcert = RTCCertificate.generate(withParams: ["expires": NSNumber(value: 100000),
//                                                         "name": "RSASSA-PKCS1-v1_5"
//        ])
        //config.iceServers = [RTCIceServer(urlStrings: Config.defaultIceServers)]
        
        let turn = Config.turnServer
        config.iceServers = [
            RTCIceServer(urlStrings: [turn.url], username: turn.username, credential: turn.credential),
            RTCIceServer(urlStrings: Config.defaultIceServers)
        
        ]
        config.continualGatheringPolicy = .gatherContinually
        config.sdpSemantics = .unifiedPlan
//        config.certificate = pcert

        return config
    }

    private func createMediaSenders() {
        guard let peerConnection = peerConnection else {
            print("Check PeerConnection")
            return
        }

//        let constraints = RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: nil)
//        let audioSource = WebRTCClient2.factory.audioSource(with: constraints)
//        localAudioTrack = WebRTCClient2.factory.audioTrack(with: audioSource, trackId: "ARDAMSa0")
//
//        let mediaTrackStreamIDs = ["ARDAMS"]
//
//        peerConnection.add(localAudioTrack!, streamIds: mediaTrackStreamIDs)
//
//        let videoSource = WebRTCClient2.factory.videoSource()
//        localVideoSource = videoSource
//        let videoTrack = WebRTCClient2.factory.videoTrack(with: videoSource, trackId: "ARDAMSv0")
//        localVideoTrack = videoTrack
//        //localVideoTrack?.isEnabled = false
//        videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
//
//        peerConnection.add(videoTrack, streamIds: mediaTrackStreamIDs)

        remoteVideoTrack = peerConnection.transceivers.first { $0.mediaType == .video }?.receiver.track as? RTCVideoTrack
    }

    private func createDataSenders() {
        if let dataChannel = createDataChannel() {
            self.localDataChannel = dataChannel
        }
    }

    private func createDataChannel() -> RTCDataChannel? {
        let config = RTCDataChannelConfiguration()
        guard let dataChannel = peerConnection?.dataChannel(forLabel: "messages", configuration: config) else {
            debugPrint("Warning: Couldn't create data channel.")
            return nil
        }
        return dataChannel
    }

    private func setupRemoteDataChannel(_ dataChannel: RTCDataChannel) {
        self.remoteDataChannel = dataChannel
        if let remoteDataChannel {
            remoteDataChannel.delegate = self
        }
    }

    private func configureAudioSession() {
        self.rtcAudioSession.lockForConfiguration()
        do {
            try self.rtcAudioSession.setCategory(.playAndRecord)
            try self.rtcAudioSession.overrideOutputAudioPort(.speaker)
            try self.rtcAudioSession.setActive(true)
            print("configureAudioSession")
        } catch let error {
            debugPrint("Couldn't force audio to speaker: \(error)")
        }
        self.rtcAudioSession.unlockForConfiguration()
    }
}

// MARK: UI Handling
extension WebRTCClient {
    func setupLocalRenderer(_ renderer: RTCVideoRenderer) {
        guard let localVideoTrack = localVideoTrack else {
            print("Check Local Video track")
            return
        }

        localVideoTrack.add(renderer)
    }

    func setupRemoteRenderer(_ renderer: RTCVideoRenderer) {
        guard let remoteVideoTrack = remoteVideoTrack else {
            print("Check Remote Video track")
            return
        }

        remoteVideoTrack.add(renderer)
    }

    func didCaptureLocalFrame(_ videoFrame: RTCVideoFrame) {
        guard let videoSource = localVideoSource,
            let videoCapturer = videoCapturer else { return }

        videoSource.capturer(videoCapturer, didCapture: videoFrame)
    }
}

// MARK: Message Handling
extension WebRTCClient {

    func addCandidate(_ candidate: RTCIceCandidate) {
        candidateQueue.append(candidate)
    }

    private func setCandidatesQueue() async {
        guard hasReceivedSdp else {
                return
        }

        for candidate in candidateQueue {
            try? await set(remoteCandidate: candidate)
        }
        candidateQueue.removeAll()
    }
}

extension WebRTCClient: RTCDataChannelDelegate {

    func dataChannelDidChangeState(_ dataChannel: RTCDataChannel) {
        debugPrint("dataChannel did change state: \(dataChannel.readyState.title), \(dataChannel.channelId), \(dataChannel.label)")
    }

    func dataChannel(_ dataChannel: RTCDataChannel, didReceiveMessageWith buffer: RTCDataBuffer) {
        self.delegate?.webRTCClient(self, didReceiveData: buffer.data)
    }
}

extension WebRTCClient: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        debugPrint("peerConnection new signaling state: \(stateChanged.title)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        debugPrint("peerConnection did add stream \(stream.videoTracks.count)")
        delegate?.webRTCClient(self, didAdd: stream)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        debugPrint("peerConnection did remove stream")
    }

    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        debugPrint("peerConnection should negotiate")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        delegate?.webRTCClient(self, didChangeConnectionState: newState)
//        if newState == .connected {
//            configureAudioSession()
//        }
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        debugPrint("peerConnection new gathering state: \(newState.rawValue)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        self.delegate?.webRTCClient(self, didDiscoverLocalCandidate: candidate)
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        debugPrint("peerConnection did remove candidate(s)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        setupRemoteDataChannel(dataChannel)
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didStartReceivingOn transceiver: RTCRtpTransceiver) {
       
        switch transceiver.mediaType {
        case .video:
            if let track = transceiver.receiver.track as? RTCVideoTrack {
                print("didStart video transceiver trackId", track.trackId)
                self.delegate?.webRTCClient(self, didStartReceivingOnTrack: track)
            }
        default:
            break
        }
    }
}

enum WebRTCStatus: String {
    case new, checking, connected, completed, failed, disconnected, closed, count

    var isConnected: Bool {
        self == .connected || self == .completed
    }
}

extension RTCIceConnectionState {

    var statusValue: WebRTCStatus {
        switch self {

        case .new:
            return .new
        case .checking:
            return .checking
        case .connected:
            return .connected
        case .completed:
            return .completed
        case .failed:
            return .failed
        case .disconnected:
            return .disconnected
        case .closed:
            return .closed
        case .count:
            return .count
        @unknown default:
            return .new
        }
    }
}

extension RTCSignalingState {
    var title: String {
        switch self {

        case .stable:
            return "stable"
        case .haveLocalOffer:
            return "haveLocalOffer"
        case .haveLocalPrAnswer:
            return "haveLocalPrAnswer"
        case .haveRemoteOffer:
            return "haveRemoteOffer"
        case .haveRemotePrAnswer:
            return "haveRemotePrAnswer"
        case .closed:
            return "closed"
        @unknown default:
            return "unknown"
        }
    }
}

extension RTCDataChannelState {

    var title: String {
        switch self {

        case .connecting:
            return "connecting"
        case .open:
            return "open"
        case .closing:
            return "closing"
        case .closed:
            return "closed"
        @unknown default:
            return "unknown"
        }
    }
}
