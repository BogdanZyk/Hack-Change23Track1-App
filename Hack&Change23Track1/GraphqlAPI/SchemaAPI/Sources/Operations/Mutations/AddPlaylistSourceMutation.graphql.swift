// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddPlaylistSourceMutation: GraphQLMutation {
  public static let operationName: String = "AddPlaylistSource"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddPlaylistSource($roomId: String!, $url: String!) { AddPlaylistSource(RoomId: $roomId, Url: $url) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
    ))

  public var roomId: String
  public var url: String

  public init(
    roomId: String,
    url: String
  ) {
    self.roomId = roomId
    self.url = url
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "url": url
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("AddPlaylistSource", [AddPlaylistSource?]?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Url": .variable("url")
      ]),
    ] }

    public var addPlaylistSource: [AddPlaylistSource?]? { __data["AddPlaylistSource"] }

    public init(
      addPlaylistSource: [AddPlaylistSource?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "AddPlaylistSource": addPlaylistSource._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(AddPlaylistSourceMutation.Data.self)
        ]
      ))
    }

    /// AddPlaylistSource
    ///
    /// Parent Type: `PlaylistRow`
    public struct AddPlaylistSource: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(AddPlaylistSourceMutation.Data.AddPlaylistSource.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// AddPlaylistSource.Source
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
              ObjectIdentifier(AddPlaylistSourceMutation.Data.AddPlaylistSource.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
