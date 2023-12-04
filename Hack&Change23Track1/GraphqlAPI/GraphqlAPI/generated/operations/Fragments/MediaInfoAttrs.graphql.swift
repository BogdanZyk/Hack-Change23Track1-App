// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct MediaInfoAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment MediaInfoAttrs on MediaInfo { __typename CurrentSeconds Pause Source { __typename ...SourceAttrs } Url }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("CurrentSeconds", String?.self),
    .field("Pause", Bool?.self),
    .field("Source", Source?.self),
    .field("Url", String?.self),
  ] }

  var currentSeconds: String? { __data["CurrentSeconds"] }
  var pause: Bool? { __data["Pause"] }
  var source: Source? { __data["Source"] }
  var url: String? { __data["Url"] }

  init(
    currentSeconds: String? = nil,
    pause: Bool? = nil,
    source: Source? = nil,
    url: String? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.MediaInfo.typename,
        "CurrentSeconds": currentSeconds,
        "Pause": pause,
        "Source": source._fieldData,
        "Url": url,
      ],
      fulfilledFragments: [
        ObjectIdentifier(MediaInfoAttrs.self)
      ]
    ))
  }

  /// Source
  ///
  /// Parent Type: `Source`
  struct Source: SchemaAPI.SelectionSet {
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
          ObjectIdentifier(MediaInfoAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
