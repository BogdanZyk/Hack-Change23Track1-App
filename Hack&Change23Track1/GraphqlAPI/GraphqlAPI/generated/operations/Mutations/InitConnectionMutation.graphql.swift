// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class InitConnectionMutation: GraphQLMutation {
  static let operationName: String = "InitConnection"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation InitConnection($sdp: ServerSDP!, $roomId: String!) { InitConnection(SDP: $sdp, RoomId: $roomId) { __typename ...SDPClientAttrs } }"#,
      fragments: [SDPClientAttrs.self]
    ))

  public var sdp: SchemaAPI.ServerSDP
  public var roomId: String

  public init(
    sdp: SchemaAPI.ServerSDP,
    roomId: String
  ) {
    self.sdp = sdp
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "sdp": sdp,
    "roomId": roomId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("InitConnection", InitConnection?.self, arguments: [
        "SDP": .variable("sdp"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    var initConnection: InitConnection? { __data["InitConnection"] }

    init(
      initConnection: InitConnection? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "InitConnection": initConnection._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(InitConnectionMutation.Data.self)
        ]
      ))
    }

    /// InitConnection
    ///
    /// Parent Type: `ClientSDP`
    struct InitConnection: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ClientSDP }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SDPClientAttrs.self),
      ] }

      var sdp: String { __data["Sdp"] }
      var type: String { __data["Type"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var sDPClientAttrs: SDPClientAttrs { _toFragment() }
      }

      init(
        sdp: String,
        type: String
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.ClientSDP.typename,
            "Sdp": sdp,
            "Type": type,
          ],
          fulfilledFragments: [
            ObjectIdentifier(InitConnectionMutation.Data.InitConnection.self),
            ObjectIdentifier(SDPClientAttrs.self)
          ]
        ))
      }
    }
  }
}
