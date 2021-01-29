
class Alert {
    Alert({
        this.senderName,
        this.event,
        this.start,
        this.end,
        this.description,
    });

    String senderName;
    String event;
    int start;
    int end;
    String description;

    factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json["sender_name"],
        event: json["event"],
        start: json["start"],
        end: json["end"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "sender_name": senderName,
        "event": event,
        "start": start,
        "end": end,
        "description": description,
    };
}
