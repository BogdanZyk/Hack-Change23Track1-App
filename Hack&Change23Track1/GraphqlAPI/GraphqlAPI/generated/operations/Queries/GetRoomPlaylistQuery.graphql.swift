// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class GetRoomPlaylistQuery: GraphQLQuery {
  static let operationName: String = "GetRoomPlaylist"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRoomPlaylist($roomId: String!) { GetRoomPlaylist(RoomId: $roomId) { __typename ...SourceAttrs } }"#,
      fragments: [SourceAttrs.self]
    ))

  public var roomId: String

  public init(roomId: String) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("GetRoomPlaylist", [GetRoomPlaylist?]?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    var getRoomPlaylist: [GetRoomPlaylist?]? { __data["GetRoomPlaylist"] }

    init(
      getRoomPlaylist: [GetRoomPlaylist?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "GetRoomPlaylist": getRoomPlaylist._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(GetRoomPlaylistQuery.Data.self)
        ]
      ))
    }

    /// GetRoomPlaylist
    ///
    /// Parent Type: `Source`
    struct GetRoomPlaylist: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SourceAttrs.self),
      ] }

      var name: String? { __data["Name"] }
      var id: String? { __data["Id"] }
      var cover: String? { __data["Cover"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var sourceAttrs: SourceAttrs { _toFragment() }
      }

      init(
        name: String? = nil,
        id: String? = nil,
        cover: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Source.typename,
            "Name": name,
            "Id": id,
            "Cover": cover,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetRoomPlaylistQuery.Data.GetRoomPlaylist.self),
            ObjectIdentifier(SourceAttrs.self)
          ]
        ))
      }
    }
  }
}
