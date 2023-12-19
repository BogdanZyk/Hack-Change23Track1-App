// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class GetRoomPlaylistQuery: GraphQLQuery {
  static let operationName: String = "GetRoomPlaylist"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRoomPlaylist($roomId: String!) { GetRoomPlaylist(RoomId: $roomId) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
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
    /// Parent Type: `PlaylistRow`
    struct GetRoomPlaylist: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PlaylistRowAttrs.self),
      ] }

      var id: String { __data["Id"] }
      var index: Int { __data["Index"] }
      var source: Source { __data["Source"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var playlistRowAttrs: PlaylistRowAttrs { _toFragment() }
      }

      init(
        id: String,
        index: Int,
        source: Source
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.PlaylistRow.typename,
            "Id": id,
            "Index": index,
            "Source": source._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(GetRoomPlaylistQuery.Data.GetRoomPlaylist.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// GetRoomPlaylist.Source
      ///
      /// Parent Type: `Source`
      struct Source: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

        var id: String { __data["Id"] }
        var cover: String { __data["Cover"] }
        var name: String { __data["Name"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var sourceAttrs: SourceAttrs { _toFragment() }
        }

        init(
          id: String,
          cover: String,
          name: String
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Source.typename,
              "Id": id,
              "Cover": cover,
              "Name": name,
            ],
            fulfilledFragments: [
              ObjectIdentifier(GetRoomPlaylistQuery.Data.GetRoomPlaylist.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
