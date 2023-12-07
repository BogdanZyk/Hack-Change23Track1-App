// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct RoomAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment RoomAttrs on Room { __typename MediaInfo { __typename ...MediaInfoAttrs } Id Likes Private Image Key Name Members { __typename ...UserAttrs } Owner { __typename Id } }"#
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
    .field("Members", [Member?]?.self),
    .field("Owner", Owner?.self),
  ] }

  var mediaInfo: MediaInfo? { __data["MediaInfo"] }
  var id: String? { __data["Id"] }
  var likes: Int? { __data["Likes"] }
  var `private`: Bool? { __data["Private"] }
  var image: String? { __data["Image"] }
  var key: String? { __data["Key"] }
  var name: String? { __data["Name"] }
  var members: [Member?]? { __data["Members"] }
  var owner: Owner? { __data["Owner"] }

  init(
    mediaInfo: MediaInfo? = nil,
    id: String? = nil,
    likes: Int? = nil,
    `private`: Bool? = nil,
    image: String? = nil,
    key: String? = nil,
    name: String? = nil,
    members: [Member?]? = nil,
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
        "Members": members._fieldData,
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

    var currentSeconds: String? { __data["CurrentSeconds"] }
    var source: Source? { __data["Source"] }

    struct Fragments: FragmentContainer {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
    }

    init(
      currentSeconds: String? = nil,
      source: Source? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.MediaInfo.typename,
          "CurrentSeconds": currentSeconds,
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
            ObjectIdentifier(RoomAttrs.MediaInfo.Source.self),
            ObjectIdentifier(SourceAttrs.self),
            ObjectIdentifier(MediaInfoAttrs.Source.self)
          ]
        ))
      }
    }
  }

  /// Member
  ///
  /// Parent Type: `User`
  struct Member: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(UserAttrs.self),
    ] }

    var id: String { __data["Id"] }
    var login: String { __data["Login"] }
    var avatar: String { __data["Avatar"] }
    var email: String { __data["Email"] }

    struct Fragments: FragmentContainer {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      var userAttrs: UserAttrs { _toFragment() }
    }

    init(
      id: String,
      login: String,
      avatar: String,
      email: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Id": id,
          "Login": login,
          "Avatar": avatar,
          "Email": email,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomAttrs.Member.self),
          ObjectIdentifier(UserAttrs.self)
        ]
      ))
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
