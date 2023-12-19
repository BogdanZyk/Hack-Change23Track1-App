// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct RoomAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment RoomAttrs on Room { __typename MediaInfo { __typename ...MediaInfoAttrs } Id Likes Private Image Key Name Owner { __typename Id } }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
  static var __selections: [ApolloAPI.Selection] { [
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

  var mediaInfo: MediaInfo? { __data["MediaInfo"] }
  var id: String? { __data["Id"] }
  var likes: Int? { __data["Likes"] }
  var `private`: Bool? { __data["Private"] }
  var image: String? { __data["Image"] }
  var key: String? { __data["Key"] }
  var name: String? { __data["Name"] }
  var owner: Owner? { __data["Owner"] }

  init(
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
  struct MediaInfo: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(MediaInfoAttrs.self),
    ] }

    var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
    var durationSeconds: Double? { __data["DurationSeconds"] }
    var source: Source? { __data["Source"] }

    struct Fragments: FragmentContainer {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
    }

    init(
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
  struct Owner: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("Id", String.self),
    ] }

    var id: String { __data["Id"] }

    init(
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
