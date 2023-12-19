// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct RoomAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment RoomAttrs on Room { __typename MediaInfo { __typename ...MediaInfoAttrs } Id Likes Private Image Key Name Owner { __typename Id } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("MediaInfo", MediaInfo?.self),
    .field("Id", String?.self),
    .field("Likes", Int?.self),
    .field("Private", Bool?.self),
    .field("Image", String?.self),
    .field("Key", String?.self),
    .field("Name", String?.self),
    .field("Owner", Owner?.self),
  ] }

  public var mediaInfo: MediaInfo? { __data["MediaInfo"] }
  public var id: String? { __data["Id"] }
  public var likes: Int? { __data["Likes"] }
  public var `private`: Bool? { __data["Private"] }
  public var image: String? { __data["Image"] }
  public var key: String? { __data["Key"] }
  public var name: String? { __data["Name"] }
  public var owner: Owner? { __data["Owner"] }

  public init(
    mediaInfo: MediaInfo? = nil,
    id: String? = nil,
    likes: Int? = nil,
    `private`: Bool? = nil,
    image: String? = nil,
    key: String? = nil,
    name: String? = nil,
    owner: Owner? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Room.typename,
        "MediaInfo": mediaInfo._fieldData,
        "Id": id,
        "Likes": likes,
        "Private": `private`,
        "Image": image,
        "Key": key,
        "Name": name,
        "Owner": owner._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(RoomAttrs.self)
      ]
    ))
  }

  /// MediaInfo
  ///
  /// Parent Type: `MediaInfo`
  public struct MediaInfo: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(MediaInfoAttrs.self),
    ] }

    public var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
    public var durationSeconds: Double? { __data["DurationSeconds"] }
    public var source: Source? { __data["Source"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
    }

    public init(
      currentTimeSeconds: Double? = nil,
      durationSeconds: Double? = nil,
      source: Source? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.MediaInfo.typename,
          "CurrentTimeSeconds": currentTimeSeconds,
          "DurationSeconds": durationSeconds,
          "Source": source._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomAttrs.MediaInfo.self),
          ObjectIdentifier(MediaInfoAttrs.self)
        ]
      ))
    }

    /// MediaInfo.Source
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
            ObjectIdentifier(RoomAttrs.MediaInfo.Source.self),
            ObjectIdentifier(SourceAttrs.self),
            ObjectIdentifier(MediaInfoAttrs.Source.self)
          ]
        ))
      }
    }
  }

  /// Owner
  ///
  /// Parent Type: `User`
  public struct Owner: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("Id", String.self),
    ] }

    public var id: String { __data["Id"] }

    public init(
      id: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Id": id,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomAttrs.Owner.self)
        ]
      ))
    }
  }
}
