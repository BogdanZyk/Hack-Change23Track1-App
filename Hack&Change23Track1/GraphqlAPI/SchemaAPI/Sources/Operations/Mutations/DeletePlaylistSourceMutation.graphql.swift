// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeletePlaylistSourceMutation: GraphQLMutation {
  public static let operationName: String = "DeletePlaylistSource"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
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

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("DeletePlaylistSource", [DeletePlaylistSource?]?.self, arguments: [
        "PlaylistRowId": .variable("playlistRowId"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    public var deletePlaylistSource: [DeletePlaylistSource?]? { __data["DeletePlaylistSource"] }

    public init(
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
    public struct DeletePlaylistSource: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PlaylistRowAttrs.self),
      ] }

      public var id: String { __data["Id"] }
      public var index: Int { __data["Index"] }
      public var source: Source { __data["Source"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var playlistRowAttrs: PlaylistRowAttrs { _toFragment() }
      }

      public init(
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
      public struct Source: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

        public var id: String { __data["Id"] }
        public var cover: String { __data["Cover"] }
        public var name: String { __data["Name"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var sourceAttrs: SourceAttrs { _toFragment() }
        }

        public init(
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
