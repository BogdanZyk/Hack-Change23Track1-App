// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class DeletePlaylistSourceMutation: GraphQLMutation {
  static let operationName: String = "DeletePlaylistSource"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeletePlaylistSource($playlistRowId: String!, $roomId: String!) { DeletePlaylistSource(PlaylistRowId: $playlistRowId, RoomId: $roomId) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
    ))

  public var playlistRowId: String
  public var roomId: String

  public init(
    playlistRowId: String,
    roomId: String
  ) {
    self.playlistRowId = playlistRowId
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "playlistRowId": playlistRowId,
    "roomId": roomId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("DeletePlaylistSource", [DeletePlaylistSource?]?.self, arguments: [
        "PlaylistRowId": .variable("playlistRowId"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    var deletePlaylistSource: [DeletePlaylistSource?]? { __data["DeletePlaylistSource"] }

    init(
      deletePlaylistSource: [DeletePlaylistSource?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "DeletePlaylistSource": deletePlaylistSource._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(DeletePlaylistSourceMutation.Data.self)
        ]
      ))
    }

    /// DeletePlaylistSource
    ///
    /// Parent Type: `PlaylistRow`
    struct DeletePlaylistSource: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(DeletePlaylistSourceMutation.Data.DeletePlaylistSource.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// DeletePlaylistSource.Source
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
              ObjectIdentifier(DeletePlaylistSourceMutation.Data.DeletePlaylistSource.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
