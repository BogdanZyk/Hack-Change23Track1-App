// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class MovePlaylistSourcePositionMutation: GraphQLMutation {
  static let operationName: String = "MovePlaylistSourcePosition"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation MovePlaylistSourcePosition($position: Int!, $roomId: String!, $playlistRowId: String!) { MovePlaylistSourcePosition( Position: $position RoomId: $roomId PlaylistRowId: $playlistRowId ) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
    ))

  public var position: Int
  public var roomId: String
  public var playlistRowId: String

  public init(
    position: Int,
    roomId: String,
    playlistRowId: String
  ) {
    self.position = position
    self.roomId = roomId
    self.playlistRowId = playlistRowId
  }

  public var __variables: Variables? { [
    "position": position,
    "roomId": roomId,
    "playlistRowId": playlistRowId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("MovePlaylistSourcePosition", [MovePlaylistSourcePosition?]?.self, arguments: [
        "Position": .variable("position"),
        "RoomId": .variable("roomId"),
        "PlaylistRowId": .variable("playlistRowId")
      ]),
    ] }

    var movePlaylistSourcePosition: [MovePlaylistSourcePosition?]? { __data["MovePlaylistSourcePosition"] }

    init(
      movePlaylistSourcePosition: [MovePlaylistSourcePosition?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "MovePlaylistSourcePosition": movePlaylistSourcePosition._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(MovePlaylistSourcePositionMutation.Data.self)
        ]
      ))
    }

    /// MovePlaylistSourcePosition
    ///
    /// Parent Type: `PlaylistRow`
    struct MovePlaylistSourcePosition: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(MovePlaylistSourcePositionMutation.Data.MovePlaylistSourcePosition.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// MovePlaylistSourcePosition.Source
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
              ObjectIdentifier(MovePlaylistSourcePositionMutation.Data.MovePlaylistSourcePosition.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
