// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class HideMessageMutation: GraphQLMutation {
  public static let operationName: String = "HideMessage"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation HideMessage($roomId: String!, $messageId: String!) { HideMessage(RoomId: $roomId, MessageId: $messageId) }"#
    ))

  public var roomId: String
  public var messageId: String

  public init(
    roomId: String,
    messageId: String
  ) {
    self.roomId = roomId
    self.messageId = messageId
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "messageId": messageId
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("HideMessage", Bool?.self, arguments: [
        "RoomId": .variable("roomId"),
        "MessageId": .variable("messageId")
      ]),
    ] }

    public var hideMessage: Bool? { __data["HideMessage"] }

    public init(
      hideMessage: Bool? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "HideMessage": hideMessage,
        ],
        fulfilledFragments: [
          ObjectIdentifier(HideMessageMutation.Data.self)
        ]
      ))
    }
  }
}
