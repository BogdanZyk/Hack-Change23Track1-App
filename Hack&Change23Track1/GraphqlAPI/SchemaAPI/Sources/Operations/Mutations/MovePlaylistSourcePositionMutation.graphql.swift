// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class MovePlaylistSourcePositionMutation: GraphQLMutation {
  public static let operationName: String = "MovePlaylistSourcePosition"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
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

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("MovePlaylistSourcePosition", [MovePlaylistSourcePosition?]?.self, arguments: [
        "Position": .variable("position"),
        "RoomId": .variable("roomId"),
        "PlaylistRowId": .variable("playlistRowId")
      ]),
    ] }

    public var movePlaylistSourcePosition: [MovePlaylistSourcePosition?]? { __data["MovePlaylistSourcePosition"] }

    public init(
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
    public struct MovePlaylistSourcePosition: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PlaylistRowAttrs.self),
      ] }

      public var id: String? { __data["Id"] }
      public var index: Int? { __data["Index"] }
      public var source: Source? { __data["Source"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var playlistRowAttrs: PlaylistRowAttrs { _toFragment() }
      }

      public init(
        id: String? = nil,
        index: Int? = nil,
        source: Source? = nil
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
      public struct Source: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

        public var id: String? { __data["Id"] }
        public var cover: String? { __data["Cover"] }
        public var name: String? { __data["Name"] }
        public var url: String? { __data["Url"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var sourceAttrs: SourceAttrs { _toFragment() }
        }

        public init(
          id: String? = nil,
          cover: String? = nil,
          name: String? = nil,
          url: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Source.typename,
              "Id": id,
              "Cover": cover,
              "Name": name,
              "Url": url,
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
