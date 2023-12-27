// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SendReactionMutation: GraphQLMutation {
  public static let operationName: String = "SendReaction"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SendReaction($messageId: String!, $reaction: String!, $roomId: String!) { SendReaction(MessageId: $messageId, Reaction: $reaction, RoomId: $roomId) }"#
    ))

  public var messageId: String
  public var reaction: String
  public var roomId: String

  public init(
    messageId: String,
    reaction: String,
    roomId: String
  ) {
    self.messageId = messageId
    self.reaction = reaction
    self.roomId = roomId
  }

  public var __variables: Variables? { [
    "messageId": messageId,
    "reaction": reaction,
    "roomId": roomId
  ] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SendReaction", Bool?.self, arguments: [
        "MessageId": .variable("messageId"),
        "Reaction": .variable("reaction"),
        "RoomId": .variable("roomId")
      ]),
    ] }

    public var sendReaction: Bool? { __data["SendReaction"] }

    public init(
      sendReaction: Bool? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "SendReaction": sendReaction,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SendReactionMutation.Data.self)
        ]
      ))
    }
  }
}
